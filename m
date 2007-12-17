Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Dec 2007 18:40:21 +0000 (GMT)
Received: from wa-out-1112.google.com ([209.85.146.179]:61136 "EHLO
	wa-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20031811AbXLQSkM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Dec 2007 18:40:12 +0000
Received: by wa-out-1112.google.com with SMTP id m16so3345194waf.20
        for <linux-mips@linux-mips.org>; Mon, 17 Dec 2007 10:40:00 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        bh=Q0aNLBuxfgiX7g/CjPAS9TEtOi5pA6oHDUxDhydDeGs=;
        b=xKxHYQ9Eugxl8qEH0wFZJIbrFBhuIPwuaXC5nGODyVykGfN3qWol3QxQegORF7eQSt8XMTg2JFV22qGDzoeTKLDsb6AZv9rHFCdLrWhcG05b2A3hkjEveF+G0dwb9WhVkECplwJZkimI64tSNfEzCPk4MF7Eaq6U339x/et6SGA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=STgQVr5NUxZrUHEAt2/jKZXWB1HQc4Q6wpYen3j3iy7S+xszWKB1Mqhui+xIYcLBa+r12Enj3h9uqA1ruukDsUoMi3W2eZOXOCH0qru/ttTM92qJlPa/8H1u2i95njg11sYewfQHSqxXfLUJpqHk8hsUwl1JmywESMpwdZp353g=
Received: by 10.114.181.1 with SMTP id d1mr3505880waf.10.1197916800597;
        Mon, 17 Dec 2007 10:40:00 -0800 (PST)
Received: by 10.114.135.8 with HTTP; Mon, 17 Dec 2007 10:40:00 -0800 (PST)
Message-ID: <eea8a9c90712171040n4b5814b5vf5e0b88a61cd71c6@mail.gmail.com>
Date:	Tue, 18 Dec 2007 00:10:00 +0530
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
	boundary="----=_Part_7619_17142918.1197916800588"
References: <eea8a9c90712170031i62e4ac4ak687a198200f59920@mail.gmail.com>
	 <4766B149.5050109@directfb.org>
Return-Path: <share.kt@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17835
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: share.kt@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_7619_17142918.1197916800588
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Denis,

Thanks for the reply.
I am running same example on X86 and it is running successfully and
displaying image.
On the other hand when i am running the same example on MIPS(GTK over
DirecTFB)
image is not being displayed.

Could u plz provide some clue on it.
Thanks.

Kaka


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

------=_Part_7619_17142918.1197916800588
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi Denis,</div>
<div>&nbsp;</div>
<div>Thanks for the reply.</div>
<div>I am running same example on X86 and it is running successfully and displaying image.</div>
<div>On the other hand when i am running the same example on MIPS(GTK over DirecTFB)</div>
<div>image is not being displayed.</div>
<div>&nbsp;</div>
<div>Could u plz provide some clue on it.</div>
<div>Thanks.</div>
<div>&nbsp;</div>
<div>Kaka<br><br>&nbsp;</div>
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

------=_Part_7619_17142918.1197916800588--
