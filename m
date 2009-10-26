Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Oct 2009 15:42:31 +0100 (CET)
Received: from mail-px0-f187.google.com ([209.85.216.187]:46249 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493107AbZJZOmY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Oct 2009 15:42:24 +0100
Received: by pxi17 with SMTP id 17so1070629pxi.21
        for <multiple recipients>; Mon, 26 Oct 2009 07:42:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=n0awJNQL7baE89XvgBnw+V2N78FObBfRDWVP74/1g6E=;
        b=CBPUC7ISpzrhUqHlUqzo7y4q8YklNAzwPhVCsDPVX/lddHRc48aHLQLFtdfXE3ikwf
         KoITnQW0urEeK/ufKrA8iWmnf9w+P8vfVpjvKQ+fcIP5UgUEATb05R+Yg5mdrkmLCdDR
         UJqMZ6mgbQodn6duOng9K+BwaTEr05nB4XLxc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=g6Yt40/CCEtdpCoIiDYVUcdialibHNXLxABSS330q+6iInHMOGNc0XEm9latFvOplL
         fxNrY8BXDOR3xSovzAA8Yy4Xp59vA3Mkw+WLfjGuyfUi3Gr2i34PpIVE7PQo6NYgNHri
         Clp7seiV7KFlAy/IGCmALBriGZK0sOLkkGmEQ=
Received: by 10.114.7.39 with SMTP id 39mr598851wag.188.1256568134463;
        Mon, 26 Oct 2009 07:42:14 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm894049pzk.8.2009.10.26.07.42.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Oct 2009 07:42:13 -0700 (PDT)
Subject: Re: [PATCH -v5 02/11] MIPS: add mips_timecounter_read() to get
 high precision timestamp
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	rostedt@goodmis.org
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	David Daney <ddaney@caviumnetworks.com>,
	Adam Nemet <anemet@caviumnetworks.com>,
	Patrik Kluba <kpajko79@gmail.com>,
	Frederic Weisbecker <fweisbec@gmail.com>
In-Reply-To: <1256567646.26028.260.camel@gandalf.stny.rr.com>
References: <cover.1256482555.git.wuzhangjin@gmail.com>
	 <028867b99ec532b84963a35e7d552becc783cafc.1256483735.git.wuzhangjin@gmail.com>
	 <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256483735.git.wuzhangjin@gmail.com>
	 <1256565667.26028.257.camel@gandalf.stny.rr.com>
	 <1256567108.5642.165.camel@falcon>
	 <1256567646.26028.260.camel@gandalf.stny.rr.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Mon, 26 Oct 2009 22:42:03 +0800
Message-Id: <1256568123.5642.169.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24506
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On Mon, 2009-10-26 at 10:34 -0400, Steven Rostedt wrote:
> On Mon, 2009-10-26 at 22:25 +0800, Wu Zhangjin wrote:
> > Hi,
> > 
> > On Mon, 2009-10-26 at 10:01 -0400, Steven Rostedt wrote:
> > [...]
> > > Some patches touch core tracing code, and some are arch specific. Now
> > > the question is how do we go. I prefer that we go the path of the
> > > tracing tree (easier for me to test).
> > 
> > Just coped with the feedbacks from Frederic Weisbecker.
> > 
> > I will rebase the whole patches to your git repo(the following one?) and
> > send them out as the -v6 revision:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-2.6-trace.git tip/tracing/core
> 
> Actually, I always base off of tip itself. Don't use mine. Use this one:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip.git  tracing/core
> 
> Then we will stay in sync.
> 

Okay, pulling it...

> > 
> > >  But every patch that touches MIPS
> > > arch, needs an Acked-by from the MIPS maintainer. Which I see is Ralf
> > > (on the Cc of this patch set.)
> > > 
> > 
> > Looking forward to the feedback from Ralf, Seems he is a little busy.
> > and also looking forward to the testing result from the other MIPS
> > developers, so, we can ensure ftrace for MIPS really function!
> > 
> > Welcome to clone this branch and test it:
> > 
> > git://dev.lemote.com/rt4ls.git  linux-mips/dev/ftrace-upstream
> 
> I already have your repo as a remote ;-)
> 

Thanks :-)

> > 
> > And this document will tell you how to play with it:
> > Documentation/trace/ftrace.txt
> 
> Did you add to it?

I have never touched the file, just hope some newbies(like me) can
follow it and help to test it :-)

Thanks & Regards,
	Wu Zhangjin
