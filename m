Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Sep 2006 10:49:17 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:11428 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038526AbWI2JtQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 29 Sep 2006 10:49:16 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k8T9o7xo023782;
	Fri, 29 Sep 2006 10:50:07 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k8T9nihE023689;
	Fri, 29 Sep 2006 10:49:44 +0100
Date:	Fri, 29 Sep 2006 10:49:44 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Pak Woon <pak.woon@nec.com.au>
Cc:	linux-mips@linux-mips.org
Subject: Re: Introduction and problems cloning repository
Message-ID: <20060929094944.GA10597@linux-mips.org>
References: <451C7CE7.8040909@nec.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <451C7CE7.8040909@nec.com.au>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Sep 29, 2006 at 11:54:47AM +1000, Pak Woon wrote:

> First time poster to this mailing list so if I am not following the 
> correct protocol please let me know.
> 
> Introduction. I am a firmware developer working for NEC Australia. We 
> are currently developing a MIPS SOC device made by Wintegra.
> 
> I am trying to clone the linux-malta.git repository using the command
> "git clone http://ftp.linux-mips.org/pub/scm/linux-malta.git 
> ./linux-malta.git" but I receieve an "error: Can't lock ref". I have to 
> use http because I am sure port 9418 is blocked by the sysadmin

An good old access permission problem on the web server but I won't have
time to sort it out now.

Until then you can use gitcvs to access the repositories:

  cvs -d :pserver:anonymous@git.linux-mips.org:/pub/scm/linux.git co -d linux-malta -P <branch>

Where <branch> is one of linux-2.0, linux-2.2, linux-2.4, MaltaRef_2_4,
MaltaRef_2_6 and master - if your firewall allows port 2401 that is ...

But why are you still using the linux-malta repository?  Since ~ 5 months
it is no longer being updated and has effectivly been replaced with
linux.git repository.  Of this repository there are also snapshots of all
tagged versions available.

  Ralf
