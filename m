Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g626t8nC029959
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 1 Jul 2002 23:55:08 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g626t8Hp029958
	for linux-mips-outgoing; Mon, 1 Jul 2002 23:55:08 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from rwcrmhc53.attbi.com (rwcrmhc53.attbi.com [204.127.198.39])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g626t2nC029944
	for <linux-mips@oss.sgi.com>; Mon, 1 Jul 2002 23:55:02 -0700
Received: from ocean.lucon.org ([12.234.143.38]) by rwcrmhc53.attbi.com
          (InterMail vM.4.01.03.27 201-229-121-127-20010626) with ESMTP
          id <20020702065850.OAAY15755.rwcrmhc53.attbi.com@ocean.lucon.org>;
          Tue, 2 Jul 2002 06:58:50 +0000
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 4CBAF125D3; Mon,  1 Jul 2002 23:58:49 -0700 (PDT)
Date: Mon, 1 Jul 2002 23:58:49 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Eric Christopher <echristo@redhat.com>
Cc: linux-mips@oss.sgi.com, GNU C Library <libc-alpha@sources.redhat.com>,
   binutils@sources.redhat.com
Subject: Re: MIPS GOT overflow in gcc 3.2.
Message-ID: <20020701235849.A6382@lucon.org>
References: <20020701184640.A2043@lucon.org> <1025575632.30577.64.camel@ghostwheel.cygnus.com> <1025579401.1785.0.camel@ghostwheel.cygnus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1025579401.1785.0.camel@ghostwheel.cygnus.com>; from echristo@redhat.com on Mon, Jul 01, 2002 at 08:09:59PM -0700
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jul 01, 2002 at 08:09:59PM -0700, Eric Christopher wrote:
> 
> > AFAIK it happens to mozilla as well.
> > 
> > Guh.
> 
> There are a few different possible solutions, one is to do the
> -fPIC/-fpic split, another is to copy to SGI multigot, I'm sure there
> are other solutions as well...
> 

I am testing this patch now. It will take a day to verify it.


H.J.
----
2002-07-02  H.J. Lu <hjl@gnu.org>

	* ltcf-gcj.sh (ac_cv_prog_cc_pic): Add "-Wa,-xgot" for
	Linux/mips.

--- ltcf-gcj.sh.xgot	Mon Sep 10 08:39:17 2001
+++ ltcf-gcj.sh	Mon Jul  1 23:49:06 2002
@@ -639,6 +639,14 @@ fi
 	 ac_cv_prog_cc_pic=-Kconform_pic
       fi
       ;;
+    linux*) 
+      ac_cv_prog_cc_pic='-fPIC'
+      case $host_cpu in
+      mips*)  
+	ac_cv_prog_cc_pic="$ac_cv_prog_cc_pic -Wa,-xgot"
+	;;      
+      esac
+      ;;      
     *)
       ac_cv_prog_cc_pic='-fPIC'
       ;;
