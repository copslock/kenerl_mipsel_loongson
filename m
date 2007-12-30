Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Dec 2007 07:00:49 +0000 (GMT)
Received: from py-out-1112.google.com ([64.233.166.181]:34756 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20024712AbXL3HAl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 30 Dec 2007 07:00:41 +0000
Received: by py-out-1112.google.com with SMTP id a73so421774pye.22
        for <linux-mips@linux-mips.org>; Sat, 29 Dec 2007 23:00:29 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=exnC39iNyNGTo6wpEC8agCkSP6qyZAeS2fWhHU/6NUU=;
        b=Hr59hWyIlNP8SW281xSOv8q0+5gh2Amr5q/Rpo+pUDTmPf18SFdiIZhzV1b2DegyBD4r04uJdwA2b36n6iyfYK2GW207w7phdMn41B/ZAJELVaS0XLNrBfi4WM65+BZ+yzaWv/HdOgpff40KIq0O6t/9HJjz9MuiqE/hd9gzTtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a259OGKc1RPNUwJ1c5g6rOCrYPNqXGbitj3LgyjW7ybubkHBzBAVK5QN9yZOZQNIpBRsBaSh4yqCdz45aj6yqUgUS35T9KRsztrXwnl1m4ecqRDx5VaF94qk2tXF7ar2A9GO1t5Vl5OUhmKUFRNsM1/n85kd3mXiYl3/63B0zP0=
Received: by 10.65.121.9 with SMTP id y9mr21966857qbm.26.1198998029306;
        Sat, 29 Dec 2007 23:00:29 -0800 (PST)
Received: by 10.65.23.2 with HTTP; Sat, 29 Dec 2007 23:00:29 -0800 (PST)
Message-ID: <5054fdb40712292300u3b09b012o4cf4032b446cb870@mail.gmail.com>
Date:	Sun, 30 Dec 2007 15:00:29 +0800
From:	"Asho Yeh" <ashoyeh@gmail.com>
To:	kaka <share.kt@gmail.com>
Subject: Re: [directfb-users] Fill rectangle is not filling the screen with the COLOR(ALways filling the screen with Black color)
Cc:	"Denis Oliver Kropp" <dok@directfb.org>, linux-mips@linux-mips.org,
	uclinux-dev@uclinux.org, linux-fbdev-users@lists.sourceforge.net,
	directfb-dev@directfb.org, celinux-dev@tree.celinuxforum.org,
	directfb-users@directfb.org
In-Reply-To: <eea8a9c90712201011v58dbe4a1of2683770c830f928@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <eea8a9c90712201011v58dbe4a1of2683770c830f928@mail.gmail.com>
Return-Path: <ashoyeh@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17898
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashoyeh@gmail.com
Precedence: bulk
X-list: linux-mips

Hi If your fillrectangle is software only, maybe the the drawing and
bliiting function in generic.c can help.

I remembered the drawing function will set the color in the
gAcquire(). How about give it a try to see the color is really set in
the function.

2007/12/21, kaka <share.kt@gmail.com>:
>
> >
> > Hi Denis,
> >
> > I am writing gfx driver for DirectFB on BroadCom chip.
> > Right now i am using FBdev system to display graphics on BCM chip(MIPS
> platform)  which should use software fallbacks from DirectFB.Later on i 'll
> add hardware accelerartion also.
> > My framebuffer driver for BCM chip is working fine. I have checked it by
> running a small example. Also the gfxdriver for directFB is working fine for
> Video and Image.
> > The problem which i am facing right now is that i am running the fill
> rectangle example.
> > IT is not filling any color in the rectangle. I am always getting the
> black screen.
> >
> > Could you plz provide some clue on it ?
> > Also could you plz specify the file name and function in which directFB
> library is writing into the framebuffer memory the color pixel information?
> >
> > Thanks in Advance.
> > kaka
> >
> >
> >
> > On 12/17/07, Denis Oliver Kropp < dok@directfb.org> wrote:
> >
> > > kaka wrote:
> > > > HI ALL,
> > > >
> > > > We have successfully cross compiled GTK and DIRECTFB with all its
> > > > dependencies for MIPS board.
> > > > On running the basic test example of GTK, it is getting struck in the
> thread
> > > > loop infinitely.
> > > > We had put the  "debug printf"  statement in the gtkmain.c and
> debugged the
> > > > test example.
> > > > It is getting struck in the * g_main_loop_run (loop);* given below is
> > > > the  code(code
> > > > snippet from gtkmain.c)
> > > >
> > > > void
> > > > gtk_main (void)
> > > > {
> > > >   GList *tmp_list;
> > > >   GList *functions;
> > > >   GtkInitFunction *init;
> > > >   GMainLoop *loop;
> > > > printf("\n%s :: %d\n",__FILE__,__LINE__);
> > > >   gtk_main_loop_level++;
> > > >
> > > >   loop = g_main_loop_new (NULL, TRUE);
> > > >   main_loops = g_slist_prepend (main_loops, loop);
> > > > printf("\n%s :: %d\n",__FILE__,__LINE__);
> > > >   tmp_list = functions = init_functions;
> > > >   init_functions = NULL;
> > > >
> > > >   while (tmp_list)
> > > >     {
> > > >       init = tmp_list->data;
> > > >       tmp_list = tmp_list->next;
> > > >
> > > >       (* init->function) (init->data);
> > > >       g_free (init);
> > > >     }
> > > >   g_list_free (functions);
> > > > printf("\n%s :: %d\n",__FILE__,__LINE__);
> > > >   if (g_main_loop_is_running (main_loops->data))
> > > >     {
> > > >    * printf("\n%s :: %d\n",__FILE__,__LINE__);
> > > >       GDK_THREADS_LEAVE ();
> > > >       g_main_loop_run (loop);
> > > >       GDK_THREADS_ENTER ();
> > > > *      printf("\n%s :: %d\n",__FILE__,__LINE__);
> > >
> > > That's normal. If you want runtime you have to create a timer or
> register idle or timeout functions.
> > >
> > > >       gtk_container_add (GTK_CONTAINER (window), pMainWidget);
> > > >  printf("\n\n\ngtk_container_add (GTK_CONTAINER
> (window),
> > > > pMainWidget);\n\n\n") ;
> > > >       gtk_widget_show (window);
> > > > printf("\n\n\nABHISHEK START OF gtk_main\n\n\n");
> > > >       gtk_main ();
> > > > printf("\n\n\nABHISHEK END OF gtk_main\n\n\n");
> > > >       return 0;
> > >
> > > Simply/weakly put: it should not return before the application is quit.
> > >
> > > --
> > > Best regards,
> > > Denis Oliver Kropp
> > >
> > > .------------------------------------------.
> > > | DirectFB - Hardware accelerated graphics |
> > > | http://www.directfb.org/                 |
> > > "------------------------------------------"
> > >
> >
> >
> >
> > --
> > Thanks & Regards,
> > kaka
>
>
>
> --
> Thanks & Regards,
> kaka
> _______________________________________________
> directfb-users mailing list
> directfb-users@directfb.org
> http://mail.directfb.org/cgi-bin/mailman/listinfo/directfb-users
>
>
