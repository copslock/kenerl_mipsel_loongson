Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Dec 2007 18:09:16 +0000 (GMT)
Received: from nz-out-0506.google.com ([64.233.162.227]:39087 "EHLO
	nz-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S28583882AbXLTSJH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Dec 2007 18:09:07 +0000
Received: by nz-out-0506.google.com with SMTP id n1so1711871nzf.24
        for <linux-mips@linux-mips.org>; Thu, 20 Dec 2007 10:08:54 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        bh=+g6WenyiBCk9D0+heMpoopfxEp9mpC2ZpRYJHftUdII=;
        b=KCVVKrmO8pslTmnPfDu408Ksu0/qgAi7NN/xU4tlZoAllUEvXAzmgVbx5P9dcsTCautlfm8/h761Fw12DTiBKKdyoFw6biUt8gcv2VW4/2AvYSwFb3dEnQg11OLW8iP51MAgVm0tOPZjLJgIwklB+U2rND0zJ/tyVaN6iRaL7Q0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=TPk+iKLiAIB2w1lhPb6LNc3y3Tx18irkZEWQMie5r4ThueKqXtYobeUwKBUwl/PV1oumPf+Os7KYHKqFIPCtAqPmipKYOalCBxAHbcaUJBxV0RfO/I+P6kP9nUxKA4gqku65ZJyxvVc4KyeLYd+swmQpUSQfbHsnyNZ2VCrgodg=
Received: by 10.115.55.1 with SMTP id h1mr288171wak.69.1198174134057;
        Thu, 20 Dec 2007 10:08:54 -0800 (PST)
Received: by 10.114.135.8 with HTTP; Thu, 20 Dec 2007 10:08:54 -0800 (PST)
Message-ID: <eea8a9c90712201008n37a9a759j6dcee5ee067f918a@mail.gmail.com>
Date:	Thu, 20 Dec 2007 23:38:54 +0530
From:	kaka <share.kt@gmail.com>
To:	"Denis Oliver Kropp" <dok@directfb.org>
Subject: Re: [directfb-dev] Error in running gtk example on cross compiled GTK with DirectFB on MIPS board
Cc:	linux-mips@linux-mips.org, uclinux-dev@uclinux.org,
	celinux-dev@tree.celinuxforum.org,
	linux-fbdev-users@lists.sourceforge.net,
	directfb-users@directfb.org, directfb-dev@directfb.org
In-Reply-To: <4766B149.5050109@directfb.org>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_18098_26786107.1198174134052"
References: <eea8a9c90712170031i62e4ac4ak687a198200f59920@mail.gmail.com>
	 <4766B149.5050109@directfb.org>
Return-Path: <share.kt@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17863
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: share.kt@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_18098_26786107.1198174134052
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Denis,

I am writing gfx driver for DirectFB on BroadCom chip.
Right now i am using FBdev system to display graphics on BCM chip(MIPS
platform)  which should use software fallbacks from DirectFB.Later on i 'll
add hardware accelerartion also.
My framebuffer driver for BCM chip is working fine. I have checked it by
running a small example. Also the gfxdriver for directFB is working fine for
Video and Image.
The problem which i am facing right now is that i am running the fill
rectangle example.
IT is not filling any color in the rectangle. I am always getting the black
screen.

Could you plz provide some clue on it ?
Also could you plz specify the file name and function in which directFB
library is writing into the framebuffer memory the color pixel information?

Thanks in Advance.
kaka



On 12/17/07, Denis Oliver Kropp <dok@directfb.org> wrote:
>
> kaka wrote:
> > HI ALL,
> >
> > We have successfully cross compiled GTK and DIRECTFB with all its
> > dependencies for MIPS board.
> > On running the basic test example of GTK, it is getting struck in the
> thread
> > loop infinitely.
> > We had put the  "debug printf"  statement in the gtkmain.c and debugged
> the
> > test example.
> > It is getting struck in the * g_main_loop_run (loop);* given below is
> > the  code(code
> > snippet from gtkmain.c)
> >
> > void
> > gtk_main (void)
> > {
> >   GList *tmp_list;
> >   GList *functions;
> >   GtkInitFunction *init;
> >   GMainLoop *loop;
> > printf("\n%s :: %d\n",__FILE__,__LINE__);
> >   gtk_main_loop_level++;
> >
> >   loop = g_main_loop_new (NULL, TRUE);
> >   main_loops = g_slist_prepend (main_loops, loop);
> > printf("\n%s :: %d\n",__FILE__,__LINE__);
> >   tmp_list = functions = init_functions;
> >   init_functions = NULL;
> >
> >   while (tmp_list)
> >     {
> >       init = tmp_list->data;
> >       tmp_list = tmp_list->next;
> >
> >       (* init->function) (init->data);
> >       g_free (init);
> >     }
> >   g_list_free (functions);
> > printf("\n%s :: %d\n",__FILE__,__LINE__);
> >   if (g_main_loop_is_running (main_loops->data))
> >     {
> >    * printf("\n%s :: %d\n",__FILE__,__LINE__);
> >       GDK_THREADS_LEAVE ();
> >       g_main_loop_run (loop);
> >       GDK_THREADS_ENTER ();
> > *      printf("\n%s :: %d\n",__FILE__,__LINE__);
>
> That's normal. If you want runtime you have to create a timer or register
> idle or timeout functions.
>
> >       gtk_container_add (GTK_CONTAINER (window), pMainWidget);
> >  printf("\n\n\ngtk_container_add (GTK_CONTAINER (window),
> > pMainWidget);\n\n\n") ;
> >       gtk_widget_show (window);
> > printf("\n\n\nABHISHEK START OF gtk_main\n\n\n");
> >       gtk_main ();
> > printf("\n\n\nABHISHEK END OF gtk_main\n\n\n");
> >       return 0;
>
> Simply/weakly put: it should not return before the application is quit.
>
> --
> Best regards,
> Denis Oliver Kropp
>
> .------------------------------------------.
> | DirectFB - Hardware accelerated graphics |
> | http://www.directfb.org/                 |
> "------------------------------------------"
>



-- 
Thanks & Regards,
kaka

------=_Part_18098_26786107.1198174134052
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi Denis,</div>
<div>&nbsp;</div>
<div>I am writing gfx driver for DirectFB on&nbsp;BroadCom chip.</div>
<div>Right now i am using&nbsp;FBdev system to display graphics on BCM chip(MIPS platform) &nbsp;which should use&nbsp;software fallbacks from DirectFB.Later on i &#39;ll add hardware accelerartion also.&nbsp;</div>
<div>My framebuffer driver for BCM chip is working fine. I have checked it by running a small example. Also the gfxdriver for directFB is working fine for Video and Image.</div>
<div>The problem which i am facing right now is that i am running the fill rectangle example.</div>
<div>IT is not filling any color in the rectangle. I am always getting the black screen.</div>
<div>&nbsp;</div>
<div>Could you plz provide some clue on it ?</div>
<div>Also could you plz specify the file name and function in which directFB library is writing into the framebuffer memory the color pixel information?</div>
<div>&nbsp;</div>
<div>Thanks in Advance.</div>
<div>kaka</div>
<div><br><br>&nbsp;</div>
<div><span class="gmail_quote">On 12/17/07, <b class="gmail_sendername">Denis Oliver Kropp</b> &lt;<a href="mailto:dok@directfb.org">dok@directfb.org</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">kaka wrote:<br>&gt; HI ALL,<br>&gt;<br>&gt; We have successfully cross compiled GTK and DIRECTFB with all its
<br>&gt; dependencies for MIPS board.<br>&gt; On running the basic test example of GTK, it is getting struck in the thread<br>&gt; loop infinitely.<br>&gt; We had put the&nbsp;&nbsp;&quot;debug printf&quot;&nbsp;&nbsp;statement in the gtkmain.c
 and debugged the<br>&gt; test example.<br>&gt; It is getting struck in the * g_main_loop_run (loop);* given below is<br>&gt; the&nbsp;&nbsp;code(code<br>&gt; snippet from gtkmain.c)<br>&gt;<br>&gt; void<br>&gt; gtk_main (void)<br>
&gt; {<br>&gt;&nbsp;&nbsp; GList *tmp_list;<br>&gt;&nbsp;&nbsp; GList *functions;<br>&gt;&nbsp;&nbsp; GtkInitFunction *init;<br>&gt;&nbsp;&nbsp; GMainLoop *loop;<br>&gt; printf(&quot;\n%s :: %d\n&quot;,__FILE__,__LINE__);<br>&gt;&nbsp;&nbsp; gtk_main_loop_level++;<br>&gt;
<br>&gt;&nbsp;&nbsp; loop = g_main_loop_new (NULL, TRUE);<br>&gt;&nbsp;&nbsp; main_loops = g_slist_prepend (main_loops, loop);<br>&gt; printf(&quot;\n%s :: %d\n&quot;,__FILE__,__LINE__);<br>&gt;&nbsp;&nbsp; tmp_list = functions = init_functions;<br>&gt;&nbsp;&nbsp; init_functions = NULL;
<br>&gt;<br>&gt;&nbsp;&nbsp; while (tmp_list)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init = tmp_list-&gt;data;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp_list = tmp_list-&gt;next;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (* init-&gt;function) (init-&gt;data);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g_free (init);
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&gt;&nbsp;&nbsp; g_list_free (functions);<br>&gt; printf(&quot;\n%s :: %d\n&quot;,__FILE__,__LINE__);<br>&gt;&nbsp;&nbsp; if (g_main_loop_is_running (main_loops-&gt;data))<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;* printf(&quot;\n%s :: %d\n&quot;,__FILE__,__LINE__);
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GDK_THREADS_LEAVE ();<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g_main_loop_run (loop);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GDK_THREADS_ENTER ();<br>&gt; *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf(&quot;\n%s :: %d\n&quot;,__FILE__,__LINE__);<br><br>That&#39;s normal. If you want runtime you have to create a timer or register idle or timeout functions.
<br><br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gtk_container_add (GTK_CONTAINER (window), pMainWidget);<br>&gt;&nbsp;&nbsp;printf(&quot;\n\n\ngtk_container_add (GTK_CONTAINER (window),<br>&gt; pMainWidget);\n\n\n&quot;) ;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gtk_widget_show (window);
<br>&gt; printf(&quot;\n\n\nABHISHEK START OF gtk_main\n\n\n&quot;);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gtk_main ();<br>&gt; printf(&quot;\n\n\nABHISHEK END OF gtk_main\n\n\n&quot;);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br><br>Simply/weakly put: it should not return before the application is quit.
<br><br>--<br>Best regards,<br>Denis Oliver Kropp<br><br>.------------------------------------------.<br>| DirectFB - Hardware accelerated graphics |<br>| <a href="http://www.directfb.org/">http://www.directfb.org/</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |
<br>&quot;------------------------------------------&quot;<br></blockquote></div><br><br clear="all"><br>-- <br>Thanks &amp; Regards,<br>kaka 

------=_Part_18098_26786107.1198174134052--
