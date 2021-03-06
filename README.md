# learnJavaSSH 
这是一个用来记录2015年5月份学习SSH三大框架的仓库。

由于版权原因，没有直接把随书源码传上来，仓库记录的是自己学习每章时改写的代码。 </br>
下面写下学习过程的记录。学习基于电子工业出版社的《JavaEE主流开源框架》一书第一版。</br>

### 案例中用的mysql的配套数据库表:
database ssh,其下table customer,包含custname(unique) char(20),pwd char(45),age int,address char(45)</br>

### log01(2015/05/08):

#### chapter01
今天终于把第一章的struts2快速入门搞定了，基于struts2完成了一个简单的login应用，由于只是为了体验struts2的工作方法和模式，整个应用的功能很简单，都没有用到数据库。其实本质上struts2框架就是对servlet进行了一些封装，我们知道简单说来servlet就是在JavaSE基础上加上了与web浏览器打交道的功能(通过httprequest或httpresponse)。struts2框架就是为了将该过程分离，使得MVC中的M业务逻辑能从servlet中脱离，完全用JavaSE实现。由于servlet获得http的参数时还是挺繁琐的，重复代码很多，重复编程的大忌。所以struts2加入了一个浏览器与业务逻辑程序的中间媒介，通过MVC中的C控制层(过滤器，拦截器，Action)来完成servlet中的http部分的功能，成功得到浏览器请求中各参数合适形式后，交给适当的M层中的JavaSE程序。M层执行完指定适当的V显示层再次通过C层传至浏览器。总之在struts2的框架中，与浏览器交互的请求和响应都是通过C层的中间过程。这也是struts2框架的意义所在，将web应用中服务器端程序与浏览器的交互通过C层完成，分离出了应用程序核心的M层，可单独用JavaSE编写。这除了简化一些http代码，更重要的是模块分离使得单独用JavaSE中的方法调试M层成为可能，而在之前未分离的情况下必须通过http请求才能使应用程序执行，调试的目标性不强。由于struts2框架只是封闭的servlet类，使用struts2框架只要在web程序中导入适当的包，并配置好struts.xml，过滤器等就ok，不用单独安装其它程序。</br>
另外说一下，学习过程序中遇到的问题，第一次用struts2框架时，即便是很简单的应用，最常见的问题是访问时404错误。这个问题最常见的情况是需要的包未导入全，xml配置不正确。具体要看运行出错时console的出错提示而定。自己当时就是遇到了struts2.xml配置中extends="struts-default"这句多写了个s，使default写成了defaults，导致一直404找不到文件。总之细看console的出错提示，刚开始的出错一般都是文件存放位置不对，配置不正确或必要文件缺失。</br>

### log02(2015/05/09):
今天学完了第二、三、四章。但只把第二章相关的改写代码同步到了库，第三、四章内容较少，直接在这里写下记录就不上传代码了。</br>

#### chapter02
首先说第二章，该章主要大致讲了下三类控制器，没有深入讲细节，这一章主要是用struts2框架实现 了用户登陆功能，以及在M层与mysql的交互(按功能共分为了action,dao,exception,service,vo五个包)，虽然该章没有深入讲struts2的内容，但项目的M层基本实现，跨出了第一步，在M层用JDBC连接了MYSQL，加入了不少包(dao,vo,exception)来规范完成这一功能，后面只要把该系统的注册和查看信息功能实现就行。</br>

#### chapter03
再来说下第三章，该章节深入讲了拦截器，其自定义的方式就是自己写个java类，实现struts2 API提供的拦截器接口，特别要重写该实现中的intercept方法。拦截器是在action调用前后搭配用的，在用java类实现了拦截器后，使用时要先在struts.xml中定义自定义的拦截器(栈)的名字，然后依旧在struts.xml中设置该拦截器(栈)要与哪个action搭配使用,所谓的拦截器栈就是一系列的拦截器按顺序组合在一起，调用时会依次进行调用。由于struts.xml中定义的包继承了struts-default.xml，默认是整个包内的action都使用了struts-default.xml中定义的defaultStack拦截器栈的。但当自己设置了某个action使用特定的拦截器时，想仍旧使用defaultStack就必须显示指定。</br>

#### chapter04
最后说一下第四章，这部分主要讲Action的，Action完成了表单参数封装，业务逻辑调用及根据业务层结果实现页面导航选择输出，可以说是控制层中工作最多的，而且基本都要用户自己实现。这里说实现是因为struts2API定义了Action的接口，但是由于提供的接口的默认功能很少，且基本没什么意义，所以也规定可以不实现该Action接口，而直接自己新建按一定规范要求写的类(要求完成表单变量的get,set等封闭功能，并且其中有个返回值为String的无参数方法，该方法默认名为execute)。当该Action规范类中的执行方法不为execute时(有时不想用该名，或该中有很多个完成不同功能的执行方法，不可能都叫execute)，在调用使用时必须显示说明方法名，这有两大类方法，第一类为在struts.xml中定义Action类名称与类名时同时设置method为该执行方法名，这种方法还能用通配符一次设置该类中多个执行方法的对应名称，第二类方法是在JSP文件中设置，这又分为两种小方法，一种是在表单的action名称设置处将action名称改为actionname!methodname的方式设置，另一种是表单的提交submit项中加入method参数设置。</br>

### log03(2015/05/11):
#### chapter05
刚完成了第五章的内容，并根据所学的改写了自己的代码，目前该程序除之前做的登陆之外，还完成了注册及查看其它新户的信息(简易交友系统的基本功能实现了)。这一章主要讲的是如何在Action类中与Servlet API交互，由于struts2框架是MVC框架，为了M层为完全的普通JavaSE程序，在C层必然要实现客户端http与java交互的功能，这主要在过滤器，拦截器中自动实现了。但在C层的第三部分Action类中，是C层中直接调用M层的一部分，由于基本需要用户自己改写，为了单元测试方便，最好是能与servlet解耦，也成为普通的JavaSE程序。通常情况下这确实是可以的，拦截器可以直接把表单元素传给Action类，Action类完全不用知道这些变量来自于网络表单，在它看来与普通Java类中的参数传递没有什么不同。但是有的时候要求得到更多信息，这时第一种方式是使用ActionContext类，该类是Action运行时的上下文(好专业...)，其中包含了会话、请求参数等信息。所以通过该ActionContext对象可方便的获得或设置请求、会话、上下文中的属性，注意是操作它们的属性，来进行值传递。这种通过ActionContext来完成Action与ServletAPI交互的方式的好处是，Action依然与Servlet没什么关系，可当作普通Java程序运行，测试。第二种方式是使用ServletActionContext，这种方式从名字中可以发现比第一种方式多了个Servlet，也暗示了它与Servlet是耦合的，必须要在网络容器(如tomcat)下进行测试，但由于它利用了Servlet技术，可以直接获得请求、会话或上下文对象，并对其进行操作。第一种方式并没有获得这些网络对象，而是通过这些网络对象相关联的Map对象来操作其属性。第三种方式是IoC(Inverse of Control)控制反转方式，这会在Spring部分学习。Action类通过实现一系列的XXXAware接口，可以获得XXX网络对象(XXX可为ServletResponse,ServletRequest,ServletContext)，这是系统容器装配好的。在Action类的execute方法中便可以直接操作这些对象，由于要直接操作这些网络对象，并且还需要系统容器为其装配控制，所以也是与Servlet耦合的，比第二种方式更耦合得紧密，但使用也更为方便。本章完成查看其它用户信息的时候就是通过第一种ActionContext的方式在request属性中传递了所有用户信息集合，并传递到jsp进行显示。</br>
另外要注意的是，在jsp显示所有用户信息时，为了代码简洁，兼容性好，没有手动一行行输出用户信息，而是类似for循环的方式输出，这用到了JSTL标签库和EL迭代功能。EL(Expression Language)是一种表达式语言,如果只是使用EL表达式，不需要引入任何jar包，只要jsp/servlet容器实现了J2EE1.4/servlet2.4、JSP2.0规范就可以。但是要使用JSTL标签库，必须要有jstl.jar,standard.jar两个jar包和标签库对应的tld文件(用来配置与jar包中定义的java类功能中对应的标签名，有点类似xml文件的作用)，所需文件
[下载地址](http://tomcat.apache.org/taglibs/standard)。两个jar包直接放在工程lib目录或其它目录再导入工程的library库中都行。而对应tld(有多个tld后缀的文件，一起放在tld目录下)的文件夹拷到工程的WEB-INF目录下即可。另外有一个小细节，JSTL目前有1.0和1.1版(好象1.2版也出来了，没用过)，它们是不同的。它们的tld文件中设置的uri都不一样，在1.0版中为<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>，而1.1版为<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>。这在导致在jsp页面设置默认引用的uri要对应改到，否则找不到对应标签库。

### log04(2015/05/12):
上午学习了第六、七章的内容，这两章对所做的项目案例并没有太大改动，也没有新增什么功能，所以学习的代码没有push到github上来。记录一下学习体验，学完后发现第五、六、七章内容都是很相关的，讨论的都是Action类中存取、传递值或对象的一些技术手段，所以对这三章分别评价下，好对Action类传递值的技术了解更系统。由于Action类是C层中最底下的一层，直接与M层和V层打交道，所以对这几层间的值传递功能有很大需求。</br>
先温习下第五章，该部分主要说的是Action利用ServletAPI完成客户端传来的各种网络对象获取，并将其转交给M层处理。由于要获得网络对象，这与Servlet功能紧密相关，除了ActionContext方式外，ServletActionContext和IoC方式要求Action类与Servlet相耦合，使得测试运行必须在系统容器中进行。</br>

#### chapter06
第六章则介绍了另一种交互技术，通过拦截器在Action执行前后帮助封装网络的请求参数(Field-Driven方式)或对象(Model-Driven方式)，由于这都是通过拦截器来调用实现封装的，所以在Action类中要按规范定义请求的参数或对象，并设置好对应的setXXX(在Action之前的拦截器用来往Action类中传递值)和getXXX(在Action之后的拦截器用来调用方便取出Action类中的属性值，好传递给之后的jsp文件等)，这种交互技术的存取值都是通过拦截器完成的，所以Action类可完全与Servlet节耦，方便单元测试。</br>

#### chapter07
第七章更进一步利用第六章的技术，将Action类的属性进一步开发，除了第六章讲的封装客户端传来的请求参数或对象，还可以封装struts.xml中配置的参数，或自己在Action类中自定义属性(这时该属性可以没有setXXX方法，因为不需要上层传值过来，也就是不用拦截器为其赋值，但要想将该属性传给之后调用的jsp，必须要有getXXX方法，这样之后的拦截器才能取出该值传给对应的jsp)。由于Action的属性可以封闭如此多东西（网络请求范围内的参数和对象，或自定义的配置参数、属性），所以Action属性显然可以用于在不同文件或层之间进行传值用，可以实现客户端传来的网络对象（参数）、M层的对象（参数）、V层的对象（参数）间的传递和交互。第七章最后还详细介绍了Jsp如何通过getXXX方法获得Action请求范围内属性值。</br>
综合第五、六、七章的技术，总结一下。Action类有两大类传值方式：一类是通过ServletAPI的方式，这种方式通常与Servlet耦合(ActionContext方式除外，但只能操作请求属性)，也因此具有Servlet的网络特性，可以全面地操作网络请求、会话和上下文对象。另一类是通过Action类属性的封装，这种方式由于利用拦截器完成属性封装，所以Action类与Servlet是解耦的，也因此Servlet的功能较少，仅能获取网络请求的对象或参数(至少书中没说可以操作会话或上下文对象，可以是因为网络请求的操作要求最频繁，所以在Action类属性的封闭方法中实现了网络请求范围的操作，当然如何第二类方法要是还能操作会话或上下文对象的话，几乎完全替代了第一类方法的功能，还保证解耦，那应该也就不需要第一大类方法了，所以估计是实现不了)，但是Action类属性很灵活，可以自定义除网络传递来的对象外的任意对象，并保存于请求范围属性中，只要满足getXXX要求，都能传递给之后的jsp等文件。所以简单一句话就是第一类方式在Action类中操作网络对象比较强大，第二类方式操作自定义的对象或网络请求对象比较灵活。

### log05(2015/05/18):
至今天，Struts2框架部分已经学习完了。今天统一更新一下chapter08-chapter14学习的内容记录。其中chapter09中提到的国际化以及chapter10和chapter13利用Ajax完成表单校验的功能自己综合改写并进行统一，更新到了github仓库标签chapter14。</br>

#### chapter08
首先是关于第八章，这部分讲的值栈和OGNL。值栈是Struts2框架里很关键的一个部分，它是针对线程的，每次网络请求都会开启一个线程，同时生成一个值栈。这个值栈可供整个请求过程使用，在内存层面，也正是由值栈来处理Action类的值传递问题的。同一个请求用到的所有Action类实例对象(也就是该Action类中申明的所有成员变量)都是存在一个值栈中，所以保证了可以很方便地通过值栈的读取而传递Action类对象中的变量。当然值栈中还存有些其它如OGNL表达式计算过程中的中间变量或结果。OGNL是一种强大的EL表达式，它可以方便地在JSP文件中读取该次请求过程中的ActionContext。ActionContext是Action上下文，也是线程安全的，包括了Action类运行所需要的所有对象，如网络请求request、会话session等。由于ActionContext是OGNL所能访问的所有内容，也有人称它为广义的值栈(包含了传统的值栈)。关于OGNL要知道它可以方便地存取ActionContext的内容就行，OGNL需要额外导入ognl类包后使用。该章主要难点是理解ActionContext,session,Action等的相互关系，它们间的关系如下的分层图所示。
```
ActionContext:Action上下文,也被人称为广义值栈,是OGNL所能访问的范围/
├── 值栈:StackValue,是OGNL访问时的根目录/
│   ├── Action类的对象,包含其中定义的所有成员变量等
│   └── OGNL表达式的计算结果或中间变量,如循环语句中计数变量等
├── application:可访问ServletContext
├── session:可访问HttpSession
├── request:可访问HttpServletRequest
├── parameters:可访问请求参数
└── attr:按page-request-session-application顺序访问
```
值栈的重要意义是实现了Action类中属性用拦截器赋值的底层过程，引用[某博客上关于该过程的介绍](http://www.cnblogs.com/jerryxing/archive/2012/04/23/2467299.html)。
    "众所周知，Strut 2的Action类通过属性可以获得所有相关的值，如请求参数、Action配置参数、向其他Action传递属性值（通过chain结果）等等。要获得 这些参数值，我们要做的唯一一件事就是在Action类中声明与参数同名的属性，在Struts 2调用Action类的Action方法（默认是execute方法）之前，就会为相应的Action属性赋值。要完成这个功能，有很大程度上，Struts 2要依赖于ValueStack对象。这个对象贯穿整个Action的生命周期（每个Action类的对象实例会拥有一个ValueStack对象）。当 Struts 2接收到一个.action的请求后，会先建立Action类的对象实例，但并不会调用Action方法，而是先将Action类的相应属性放到 ValueStack对象的顶层节点（ValueStack对象相当于一个栈）。只是所有的属性值都是默认的值，如String类型的属性值为 null，int类型的属性值为0等。在处理完上述工作后，Struts 2就会调用拦截器链中的拦截器，当调用完所有的拦截器后，最后会调用Action类的Action方法，在调用Action方法之前，会将 ValueStack对象顶层节点中的属性值赋给Action类中相应的属性。大家要注意，在这里就给我们带来了很大的灵活性。也就是说，在Struts 2调用拦截器的过程中，可以改变ValueStack对象中属性的值，当改变某个属性值后，Action类的相应属性值就会变成在拦截器中最后改变该属性 的这个值。 从上面的描述很容易知道，在Struts 2的的Action类可以获得与属性同名的参数值就是通过不同的拦截器来处理的，如获得请求参数的拦截器是params，获得Action的配置参数的拦 截器是staticParams等。在这些拦截器内部读取相应的值，并更新ValueStack对象顶层节点的相应属性的值。而ValueStack对象 就象一个传送带，将属性值从一个拦截器传到了另一个拦截器（当然，在这其间，属性值可能改变），最后会传到Action对象，并将ValueStack对 象中的属性的值终值赋给Action类的相应属性。"</br>

#### chapter09
接下来说一下第9章，该章主要说利用Struts2框架中的properties文件定义key=value对，以抽象页面显示内容，以实现国际化。所谓国际化就是针对不同浏览器的语言设置显示不同语言版本的网页，但是网页框架是同一个，仅是显示语言进行了修改。思想很简单，就是把要显示的信息抽象出来在properties中定义，这就类似于编程语言中的宏，一个简单的抽象和替换思想。注意一点的是，国际化的测试在IE浏览器尝试成功，但360浏览器失败，不管语言顺序如何，一直显示中文版。猜想应该是360浏览器自作聪明，查看了本地操作系统的默认语言是中文，所以即使设置了优先语言是英文的情况下还是输出的中文版本。</br>

#### chapter10
第十章是介绍校验技术，因为常常需要在表单数据与数据库交互前进行检验，以发现是否满足基本要求，当不满足时可直接对应处理而不必与数据库进行交互，以减少服务器的载荷和时间消耗。传统的校验方式要经过一个完整的http请求，需要消耗不少网宽和时间，使用Ajax可优化该过程。其实仔细一想，大部分校验Ajax都不用，应该不用和服务器通信，在浏览器端就能完成，可以用javascript离线完成。但是这需要网络传输javascript代码，时间和网络开销可能得另外考虑。</br>

#### chapter11
第十一章详细介绍了在Jsp使用struts2标签。标签主要分为UI标签(生成页面元素，也就是可见的部分)和通用标签(实现逻辑、数据控制等，如循环、分支等控制标签)。该章主要介绍了在V层如何用struts2的标签进行开发。</br>

#### chapter12
第十二章介绍异常处理，主要因M层常可能出现异常，需要一定处理。在struts2框架下，M层抛出的异常可直接由Action类捕获处理，也可以Action不处理，继续抛出，在struts.xml中声明该异常映射处理方式。异常可设定特定信息，交由jsp显示给用户。</br>

#### chapter13
第十三章介绍了Ajax技术，Ajax技术是由很多成熟的技术组合出来的，并不是新创。Ajax最常见的用途就是优化第十章的校验技术，可以在用户填写表单的同时进行异步校验。当不用框架，直接完成Ajax的功能完成异步请求时要经过很繁琐的过程，在Jsp中要加入大量javascript代码，为了简化这一过程于是很多框架被开发了。struts2框架中只是集成了这些简化Ajax操作的框架中很流行的两个——dojo和DWR框架，并没有单独开发实现这一部分的框架。以DWR为例，配置dwr.xml文件便能集成DWR于struts2中，而关于要进行ajax异步校验的jsp中的代码与之前基本一致，仅仅是主题进行了设置theme="ajax"，检验便会用异步技术完成。Ajax技术的所有底层细节都在引用的dwr包中完成了，不用自己手动繁琐完成。</br>

#### chapter14
该章总结了struts2框架中各技术所用到的配置文件(xml,properties)，xml文件将所有组件联系在了一起，properties文件主要是完成key-values定义(相当于宏定义)，简单的key-values定义也可以在xml中用constant标签完成。</br>

#### Struts2框架总结
至此struts2框架已经学习完了，最后总结一下。该框架主要是处理客户端与服务器的交互(MVO模型实现)。</br>
2-8章主要讲C层如何存取、传递对象或参数。2-6章讲Action类从客户请求获取参数并传递给M层，6-8章讲Action类的对象或参数如何传递给V层(jsp)。</br>
9-13章则讲解了struts2框架在V层的应用，均是关于用户体验可见的部分。如国际化(语言版本控制)、表单信息校验(Ajax方式与传统方式)及提醒消息(异常消息机制提醒)，以及各种可用于开发jsp的struts2标签用法。

### log06(2015/05/22):
完成了struts2框架的学习后，开始了hibernate的学习。但是万事开头难，主要自己没用教材上的MyEclipse开发环境，坚持了Eclipse，所以成功编写第一个基于hibernate框架的java程序还是遇到不少问题。因为hibernate框架和前面struts2框架不同的是，它用Eclipse和Myeclipse这两个IDE下开发时有较大差异(当然是指Eclipse没有装那么多插件的情况下)，之前的struts2框架使用在Eclipse和MyEclipse下基本没有差别，均导入类包就行。但hibernate在两个IDE下的开发插件有些许差别，导致了上手比较麻烦，折腾大半天总算把问题都弄清楚，程序整成功了吧。把第一个写好的程序push到了chapter15的tag标签</br>
PS:课本上SSH这三部分每部分的章节都是第1章开始起头，为了仓库备份命名方便，改了章节命名，接上之前章节，该部分从第15章开始。

#### chapter15
hibernate框架是ORM(Object-Ralational Mapping)框架，流程结构相对比较简单。该框架主要要求用户提供3部分文件(po类,hbm.xml映射文件,cfg.xml或properties配置文件)即可运行，PO(Persistent Objects)是可持久化类，用来代表要操作的数据库中的表单内容，PO对应的hbm.xml指明PO与数据库中哪个表的哪些字段对应，而cfg.xml或properties文件则配置了如数据库连接帐号密码、驱动等配置参数。前面提到不同IDE下利用hibernate开发操作有差别，但是hibernate的原理是相通的，只要提供了前面说的那3个部分和jar包，肯定就能运行。主要是那3个文件手工编写都比较困难，又容易出错，所以一编利用相关的插件工具以简化生成过程(如正逆向工程)，不同IDE下这工具有些许差别。Eclipse和MyEclipse两个IDE所用的简化hibernate开发的插件工具不同，导致很多操作有区别。</br>
该章试写了第一个Hibernate框架的程序，果然第一步问题多多，主要出现了两个问题。解决后该程序成功运行了。</br>
第一个问题首先是开发需要的插件及使用方法，关于eclipse下hibernate插件安装(MyEclipse中集成了开发插件，不用装)可参考一条百度经验[Eclipse 在线配置 Hibernate Tools](http://jingyan.baidu.com/article/db55b609959d154ba20a2f5d.html),利用该插件配置cfg.xml及逆向工程生成po类和hbm.xml映射文件的方法(逆向工程的操作也与在MyEclipse中有差别)可参考csdn的一篇文章[eclipse从数据库逆向生成Hibernate实体类](http://blog.csdn.net/wangpeng047/article/details/6877720)。至此,Eclipse下开发hibernate的插件及利用该插件生成所必须的三部分文件都弄好了，向工程中导入Hibernate必要的jar包就可以用了(MyEclipse中默认导入了，不用再导入)。啰嗦一句，在新环境或新工具在使用一种技术要抓住该技术的关键原理(如此处hibernate的三个主要部分)，这样就不怕找不着方向了。我下的Hibernate4.3版本，教材中用的是3.X版本，这个版本差异带来了之后的第二个问题。</br>
前面的第一个问题是Eclipse和MyEclipse环境不同导致的，第二个问题是由Hibernate版本不同导致的，4.3版本居然不兼容3.x的版本，在该版本中某些旧版本的方法已经被废除了~|~。在hibernate操作数据库的时候要新建SessionFacroty类的对象，在教材中(Hibernate4.0之前的旧版)中是对Configuration类的对象,设对象名为configuration，用configuration.buildSessionFactory()便可返回一个SessionFacroty类的对象。但buildSessionFactory()方法在4.0版后便被废除了。上网查到了解决办法，说是4以后版本提供了ServiceRegistry来取代之前的方法，具体可见两个网页[Hibernate4中buildSessionFactory方法废弃问题。](http://blog.csdn.net/iaiti/article/details/9211905)和[Hibernate SessionFactory Example](http://www.roseindia.net/hibernate/hibernate4/HibernateSessionFactory.shtml)。两个网页说的方法一样，可一试，居然又提示这两网页所使用的方法中某方法被抛弃了，又上网查，发现在4.3版ServiceRegistry这种取得SessionFactory的方法也被抛弃了，用了另外的方式来实现(改动太快了...),找到了4.3版对应的更新替代方法(用了StandardServiceRegistryBuilder类)[Is buildSessionFactory() deprecated in hibernate 4?](http://stackoverflow.com/questions/8621906/is-buildsessionfactory-deprecated-in-hibernate-4)。终于成功利用教材上的测试数据库功能代码操作数据库。关于第2个问题说下感想，对于这种问题解决必须要看控制台的错误提示以及IDE提供的源码文件的错误或警告(如何用IDE的话)，然后见机行事，根据线索查找资料。</br>
PS:为保证隐私，控制台输出的数据库操作语句对表单数据的value统一用"?"代替显示了，开始还以为是编码有问题，mysql与输入编码不同，不识别之类的问题，发现多虑了，只是为隐私考虑。</br>
PS:用Egit直接从Eclipse往github上put刚更新的内容(chpater15)时老是卡着不动，又看不到详情，以为是哪里出问题，还差点重装或重写代码了。后想着试试直接用windows下的git尝试push，不用集成的Egit,发现挺好用的，而且push的时候有显示速度，这下看明白了，是https传输比较慢，耐心等了等，成功传上去了。

### log07(2015/06/03):
继续学习hibernate框架，这一次把hibernate框架学完了，并上传了整合了hibernate和struts2的最终工程，并保存为标签chapter22。因为这框架前一章是在学院电脑做的，拷到自己电脑上运行的时候居然就出错了，但是不管是Web服务器还是Mysql或jdk,Eclipse等等环境都是一样的版本，折腾了很久才发现问题在hibernate包导入的方式上不恰当。在整个hibernate的学习过程中，两次运行出问题，都是由于其jar包的导入问题。在此统一记录。</br>
第一次是将学院电脑上应用Hibernate的Java工程尝试在自己电脑上运行，出错提醒某hibernate的jar包有问题，不能用。可仔细查看，该jar包确实已经通过新建了一个library库，并将hibernate的jar包都导入进去了。为此做了多个尝试，发现两个线索:a,用一个能正常运行的使用了hibernate的Java工程做试验，在jre的默认lib路径中再加入hibernate的jar包后(并没有删除原来工程中导入的hibernate的jar包)，本来能正常运行的却出错了，提示该包中的类找不到用不了。原来工程中导入的该包没删，还在jre的默认lib路径又拷贝进去了一份，居然反而说找不到该包；b,第二个线索是在一个java工程里，hibernater的jar包用新建一个user库(并设为系统库)，将hibernate的包导入该库，运行时提示用不了这些包中的类，出错。然后将该库删除，不通过库而直接导入hibernate的jar包，工程即可正常运行。以上a,b两个线索的共同点是，当hibernate的jar包导入了系统默认的classpath路径(a中jre的lib下,b中将user库设置为了系统库)时便会出错。猜想应该是有权限的问题，在系统路径下的hibernate的jar包虽然能找到，但是要使用时权限不足，会被拒绝。所以写代码时并没有提示说导入的包找不到，在编译运行时却提示用不了。并且程序会优先在系统路径找所需要的包，而不是工程中的非系统路径，所以在情况a中虽然工程中任然有所需要的包，但是却优先使用在系统路径(jre的lib)中找到，即使最后权限问题无法使用也无法用另一份备用的。所以综上，都是因为权限问题，找到了最后却无权用不了，且包重复时优先使用系统路径下的。为了验证猜想，尝试了在非系统路径下重复导入一个jar包(mysql的驱动包同时导入apache库下和其它非系统库中)，运行发现没有任何问题，证明了主要原因是系统库的权限。第二次验证在b的情况下将hibernate的库设为非系统库，再将jar包导入该库，发现程序就能成功运行，和之前唯一的差别就是工程中新建的hibernate库没有设为系统库，进一步证明了权限导致的问题。</br>
第二次是在hibernate的最后一章，在web工程中使用hibernate时，因为之前都是用的java工程来学习尝试，发现用于web工程时又出现了问题。在该web工程中导入hibernate的jar包时是仍然是通过在java部分建立了一个hibernate库(没有设为系统库)，并导入所需java包，运行时却出错，提示找不到所需的类。将该hibernate库删除，尝试将hibernate的jar包拷贝到web项目里专门放用户自己jar包的lib下，运行成功。这应该又是权限问题，猜想web服务器没有权限调用其java部分的用户自建库里的jar包(够奇怪)。</br>
以上两次出现的应用hibernate的问题根源都是在其jar包导入方式不恰当，没有正确的权限，所以以后出现类似状况(已经导入包，却提示找不到相关类，源码编写时IDE没有提示问题)，不要盲目找自己源码的问题，很有可能是jar包导入方式导致的权限问题，尝试用别的方式导入。

#### chapter16
该部分对应原书hibernate部分的第二章，该章系统介绍了该框架的核心概念。之前说该框架必须的三大部分为持久化类(PO)，类与数据库表的映射文件，数据库连接相关的配置文件。该部分介绍了用POJO编程模式实现PO类的规范，如要求public修饰的无参构造方法，与主键对应的标识属性，属性都为private并提供set,get方法。映射文件介绍了其中常用的元素(class,id等)及多表关联需要的subclass等元素。配置文件说了hibernate.properties与hibernate.cfg.xml的等价性，且后者优先级高于前者，并介绍了设置使用非自带连接池(如C3P0连接池)的方法。除该三大部分，还介绍了表与PO类关联时可能处于的三种状态——瞬时状态，持久状态，胶管状态，及所表示的操作关系。最后简单介绍了HOL语句，它是设计为面向对象操作数据库的语句，其底层是用sql实现的。

#### chapter17
该章详细介绍了HQL语言，如全部属性查找，部分条件查找，对查找结果用聚集函数分析(如求和等)，对查找返回对象换一定规则排序，分组或子查询。

#### chapter18
该章介绍了一种表与类的映射设计方式——1张表映射多个类的情况，这称为粒度设计。按目的不同又分为基于设计的粒度设计和基于性能的粒度设计两种。前者是考虑到表中各元素的属性间的逻辑关系，进行分类；后者是从数据库读取操作的性能考虑，如使用频率高的元素分为一类，低的分为另一类。并将分好的每一类分别对应一个PO实体类以实现逻辑清晰或效能更好。

#### chapter19
该章讲存在多张表(多个实体类)时它们之间又相互关联时的问题。利用主外键、连接表等概念可使它们相互关联起来引用。按由谁引用谁的方向可分为单向关联和双向关联，按关联的数量又可分为一(或多)对一(或多)四种情况。并介绍了这四种情况下如何利用主外键或连接表的技术实现各种表间的关联。

#### chapter20
前章各表(实体类)是关联关系时如何实现，这章介绍它们之间是继承关系时的应对策略。因为hibernate借助HQL用面向对象的方式操作数据库，借助这一中间层的转换使得没有面向对象特性的数据库在上层有继承等特性。在有继承关系时，根据不同表与类的设计而有多种实现方式，分为TPS(Table Per SubClass),TPH(Table Per Class Hierarchy),TPC(Table per Concrete Class)。TPS是设计为主表与PO类中父类对应，从表分别对应子类。TPH是仅设计一张表，该表包含了各子对象映射的属性，使用标识字体区分不同对象，使得一张表可对应于多个PO类使用。TPC是设计多个表分别对应各子类，每个表包单独包含子对象类的所有属性，而各表间独立。这三种方式都仅需要一个父类与表对应的映射文件，这种继承关系是在PO类的设计中继承体现的，表其实只是与PO类对应，表间本质没有继承可言。此外，由于HQL面向对象特性，可实现多态查询。

#### chapter21
这部分介绍提升hibernate性能的一些技巧，如批量操作时及时清理缓存(session.flush()和session.clear())或不进行缓存(StatelessSession接口)以防止内存溢出的方法。不用延迟加载(默认为延迟)实现自动查询关联实例。另外batch-size属性设置可实现减少有关联的实例查询过程中查询的语句条数。</br>
在该章的优化试验中，出现过一个问题，提示一对多的关联表的Address.hbm.xml解析失败，细查发现是其中有一条<cache usage="read-write"/>语句，删掉后将没问题了，不知道该语句有什么作用。

#### chapter22
该部分对应用hibernate的最后一章即第八章。这一章在标签为chapter14的git版本项目基础上，将hibernate框架加入进去，由于二者没有重叠部分，分别处理项目中不同层次，整合很简单。但hibernate的整合出现了之前说的导入jar包的方式不对的第二次问题，算是一点小波折。此外，还暴露了一个问题，就是使用Egit并不是很熟练，merge时容易出现confilict不确定如何解决，今天出现冲突时将冲动的文件改乱了，导致组合后出现了很多问题。最终还是手动将dev分支的文件拷贝到了master分支~~。上网查发现merge或push时出现冲突的问题很多人问，看来是版本控制里一个比较麻烦的问题。最终将整合了struts2和hibernate框架的工程保存为了chapter22标签。
####Hibernate框架总结
这个框架是针对数据库操作的，其实就是对JDBC方式的一个整合改进。所以它可以用在任何JDBC可用的工程中，如java工程，而不限于web工程。该框架的概念很好理解，自己学习时主要的问题基本都出在了非框架内容部分(如git的操作问题,jar包的导入方式问题)。下一步就可以开始Spring框架了~~。

### log08(2015/06/06):
自己学习spring的时候坚持了使用eclipse，没有使用Myeclipse插件或其它插件，因为觉得它们对编写程序方面没有多大帮助，仅是导入jar包更简便。觉得用不必要的插件破坏了简单美。不过虽然没用插件也把程序都完成了，但是在一些章节还是出现了些比较麻烦的缺少jar包的问题，从报错的类名字很难看出要导入哪个包，上网查询才找到缺少的jar包名。如有的章节程序所需要的jar包根本不在spring的发行包的里，要单独下载，这问题在chapter25关于AOP的部分出现了(具体见chapter25的记录)。还有版本的更新的问题，包名可能会更改。版本差异导致的问题在hibernate部分遇到了很多，spring部分的chapter27也遇到了(具体看chapter27的记录)。看到谷歌一个人的回复说"In spring 3 the whole jar structure has been re-organized. There is no all-in-one spring.jar as before. You have to pick what you need."所以说明了spring的jar包是比较麻烦，插件确实一定程序减轻了寻找各模块所需jar包的工作，是否使用插件看自己需求吧。

#### chapter23
这一部分关于spring的概念。spring框架为了设计为无侵入式(即应用程序可最小程度依赖它，只挑选需要的功能模块导入)，将spring框架按功能分为七个模块，分别对应解决不同问题，使用时可按需求导入需要模块的jar包。这样解决了侵入的问题，但是这种精细分类导致对依赖包的判断变复杂，难以精准辨别自己所用模块需要的包(所以很多开发者选择用各种spring插件，使其自动选择依赖包，自己做AOP那章的程序时就有几个包一直没找到，费了不少劲)。接着介绍了使用spring的一般流程，即导入必要包，正确配置applicationContext.xml文件，在程序中简单几条语句即可调用spring的IoC,AOP等功能。spring框架的七个模块分别为Core(主要是Ioc技术)，AOP(面向切面编程),ORM,DAO,Web,Context,WebMVC，其中IoC和AOP是spring最重要核心的技术。

#### chapter24
这部分详细讲解core模块，即Ioc控制反转，也被称为依赖注入。IoC可实现对初始化复杂对象的统一管理，将bean对象的实例化和配置交给容器完成。这项技术的基础是反射技术和自省技术，反射可使得程序执行时动态地执行类的方法(构造方法)以获得类的对象，动态是指通过变量动态告诉程序要创建对象的类名，自省是指不知道类中有何具体属性的情况下设置它们的值。它们都利用了JavaBean类的规范。该章详细介绍了如何使用IoC,其实现过程及底层技术原理，并对何时使用IoC给了建议。在这一章尝试写了第一个使用Spring的程序，第一个程序编写没有之前hibernate第一个程序一样遇到各种麻烦，相对比较顺利。因为插件在编写程序方面没什么帮助，不像hibernate插件可以通过正逆向工程帮助编写配置文件或持久化类以提高开发效率，主要是帮助整理依赖包。我没有用spring的插件，自己单独下了spring的jar包，并上网查了IoC模块所需要的特定jar包，在hibernate部分经历的jar包导入问题的经验帮助自己顺利地完成了第一个使用IoC技术的程序。

#### chapter25
该章讲解AOP(Aspect Oriented Program)面向切面编程，它可将通用功能与业务模块分离，使得在程序任意方法处(称为切面)可插入这些通用功能，使用可全局管理这些功能更方便。通过该技术可设置在一个方法调用的前，后或调用期间执行自己设定的通用功能，也使得程序结构更清晰。该章的程序在尝试时出现了一个问题，错误提示说找不到某些类，应该缺少了jar包，看错误信息，其中有AOP的关键字，猜想应该是spring提供包中与AOP有关的部分，可全部尝试了也依然没有该找不到的类。最后上网查才发现该类根本不在spring提供的包中，需要单独下载，类名为aopalliance-1.0.jar，下载导入后程序一切正常。

#### chapter26
该章讲解spring模块中Web模块部分应用——整合struts2框架(注意spring框架的MVC模块是其自带的MVC框架，本书没有介绍spring自带的MVC框架，直接将流行的struts2框架整合进去)。该章介绍的整合案例是在struts2框架基础上将Action实例将由spring框架管理，用Ioc技术进行实例化和装配。完成了之前交友项目中struts2部分整合到spring中，为SSH三大框架完成该项目做铺垫。

#### chapter27
该章是讲DAO模块部分的应用——spring整合JDBC,它可使得JDBC的细节被隐藏起来，交由spring框架完成，使基于JDBC的数据库编程更简洁。该部分程序用eclipse且不使用spring插件尝试时出现了一些问题，之后证实是jar包缺失的问题。当时console提示"The type org.springframework.dao.DataAccessException cannot be resolved. It is indirectly referenced"问题，当然是直接上网查该异常的类在哪个包中，应该是没有导入工程中，根据网上查到的说明在两篇CSDN的博文中([博文1](http://blog.csdn.net/wwwyuanliang10000/article/details/21396689)，[博文2](http://blog.csdn.net/u012010949/article/details/17261671))都表示缺少org.springframework.transaction-3.X.X.jar包，但在自己的spring发行版中没有看到该包，猜想要么是要单独下的包或理名字更改了.这时看到另一个[网页](http://www.cnblogs.com/fuckqq/p/4107203.html),说是少了spring-tx-3.2.2.RELEASE.jar包，该包在我下的spring发行版(3.2.0版)中有，导入后程序正常。再细看名字，tx发音与transaction很像，应该就是3.2.0版后该名改了名字了，之前的两篇CSDN文中提到的是3.1.1或3.0.X版。

#### chapter28
该章讲ORM模块应用——spring整合hibnate，因hibenate中常要声明并初始化sessionFactory对象，该对象非常合适用IoC进行实例配置。该章展示了本书交友系统项目的hibernate整合到spring框架的过程，也为后之后SSH三大框架整合完成该项目做铺垫。该部分比自己想像的要麻烦得多，这部分不单单是jar导入的问题，还有hibernate版本的问题，这在hibernate学习部分已经说到了，书中所用的hibernate版本和自己用的新版功能方法都有差别，现在还在将其整合到spring中，版本问题还是存在并且和spring纠结在一起，更麻烦了。这部分的程序出现了不少问题，首先是缺少了一个单独包jta.jar,下载后将其导入。然后便出现了版本引起的问题，提示声明seesionFactory是org.springframework.orm.hibernate3.annotation.AnnotationSessionFactoryBean找不到，看名字也可以看到这个类是hibernate3XX版本的，自己用的hibernate的jar包是4.3.0版本，于是参考网上一个[网页](http://blog.sina.com.cn/s/blog_6f3fea5c0100zui7.html)，将上一个在applicationContext.xml中bean的id为sessionFactory指定的类改为了org.springframework.orm.hibernate4.LocalSessionFactoryBean,同样org.springframework.orm.hibernate3.HibernateTemplate也改为org.springframework.orm.hibernate4.HibernateTemplate，并将对应的java中导入包的hibernate3改为hibernate4。这一步的问题解决,又出现的一个问题是"java.lang.NoClassDefFoundError: org/hibernate/service/jta/platform/spi/JtaPlatform"，查了后发现一篇[博文](http://www.tuicool.com/articles/iUJBnm)，说是spring3.X.X版本与hibernate4.3.X版本结合由于类名改了会出现该问题，建议是升级spring到4.0.X及以上或降级hibernate到4.2.X及以下，自己刚好是spring3.2.0和hibernate4.3.10(这运气~~)，于是把spring4.1.0的jar包下载了,将之前3.2.0的spring包都改为4.1.0版本。还有一个注意的是虽然是spring结合hibernate，但是spring的JDBC的jar包也是被依赖的，因为它整合的hibernate的某些底层是用JDBC实现的，具体说明见[spring jdbc事务管理](http://fansofjava.iteye.com/blog/610848)。另外由于版本不同，HibernateTemplate类的各种执行数据库的方法返回的值不能自动转换为想要的数据类型(如本例中的List<Customer>),还去查看了jar包中该方法的申明，返回值明明应该对应的，最后对返回结果进行了强制类型转换，运行终于一切正常。本来spring整合hibernate各之间整合struts及JDBC类似，但由于hibernate这个奇怪的版本不兼容问题，折腾了半天，呼！

#### chapter29
该章单独介绍了一个概念——事务管理，并分别介绍了编程式事务管理和声明式事务管理，及在spring框架中如何进行实现。这些事务管理都用到了hibernate相关的类包，并与spring整合。经过了上一章对hibernate整合基本已经比较轻松了，这章的程序完成还是挺快，不过对事务处理本身的优势理解不是很多，以后慢慢体会。

#### chapter30
该章是spring部分最后一章，也是本书最后一章，对之前交友项目进一步进行整理，分别将struts2和hibernate框架整合到了spring框架中进行管理，完成了本书的目标，用SSH框架实现该交友项目。该部分的程序完成时出了点小问题，注册登陆都弄好了，但要求输出所有用户信息时转到了指定页面，却没有用户信息，只有一个表头。情况和之前stuts2里试验不登陆直接进入登陆成功的欢迎页面，使用输出所有用户信息功能时一样。之前一直怀疑是struts2里自带了检验权限认证，但又觉得有点不对，因为没有任何地方设置了哪个功能要检验，哪个不要(这问题之前一直没想明白)。这章出现这个问题是成功登陆后仍输不出信息，更不应该是权限问题。仔细排查后发现原来是功能action中定义在actionContext的结果变量名与最后显示的jsp中的变量名没对应(当时为了面向对象，把ActionContext中的表单域变成了模型对象传递，所以变量名改了)。调整了jsp里的对象名后，程序成功。为了进一步确认struts2里是否默认用了权限认证，网上查到[struts2权限认证](http://blog.csdn.net/loadhai/article/details/19121589)相关资料,发现想用权限认证必须自己进行实现，可以用拦截器或过滤器完成，默认是不会记录权限的session的。所以之前一直纠结的问题不是底层的权限导致，而仅仅是变量名没有对应，总再次尝试了之前struts2部分引出该问题的程序，发现只要变量名对应，输出都是成功的，与权限无关。至此在本书学习结束时把之前部分没想明白的矛盾都搞清楚了~!~。</br>
将全书内容完成后整合ssh的项目传到了github，标签名为chapter30。它基于SSH框架实现了注册、登陆、显示其它用户信息的功能，各页面均实现了中英双语的国际化，注册和登陆页面有表单校验功能，其中登陆出错时会提示帐户或密码错误，注册时使用Ajax异步校验用户名是否可用等。此项目基本把本书提及SSH相关的所有能用于该项目的技术都用上了。

#### Spring框架总结
到此学完了本书，spring框架提供像是一个项目的管理容器，包含了丰富的功能模块，各模块间相对独立，所以比较灵活。但项目中主要还是用了IoC完成实例化配置，其它模块的应用及整合似乎都是为了使用该spring"容器"的IoC及AOP技术的便利。
