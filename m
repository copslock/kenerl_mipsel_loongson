Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Sep 2006 18:52:51 +0100 (BST)
Received: from ims.2wire.com ([206.171.6.87]:49942 "EHLO ims.2wire.com")
	by ftp.linux-mips.org with ESMTP id S20039265AbWI2Rwt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 29 Sep 2006 18:52:49 +0100
Received: from ripper ([10.5.252.199]) by ims.2wire.com with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 29 Sep 2006 10:52:41 -0700
Date:	Fri, 29 Sep 2006 10:52:41 -0700
From:	Andrew Sharp <asharp@2wire.com>
To:	linux-mips@linux-mips.org
Subject: Re: Introduction and problems cloning repository
Message-ID: <20060929105241.423a1ade@ripper>
In-Reply-To: <20060929094944.GA10597@linux-mips.org>
References: <451C7CE7.8040909@nec.com.au>
	<20060929094944.GA10597@linux-mips.org>
Organization: 2Wire Inc.
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Sep 2006 17:52:41.0983 (UTC) FILETIME=[0F96B8F0:01C6E3F0]
Return-Path: <asharp@2wire.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12743
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: asharp@2wire.com
Precedence: bulk
X-list: linux-mips

On Fri, 29 Sep 2006 10:49:44 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Fri, Sep 29, 2006 at 11:54:47AM +1000, Pak Woon wrote:
> 
> > First time poster to this mailing list so if I am not following the 
> > correct protocol please let me know.
> > 
> > Introduction. I am a firmware developer working for NEC Australia.
> > We  are currently developing a MIPS SOC device made by Wintegra.
> > 
> > I am trying to clone the linux-malta.git repository using the
> > command "git clone http://ftp.linux-mips.org/pub/scm/linux-malta.git
> > 
> > ./linux-malta.git" but I receieve an "error: Can't lock ref". I have
> > to  use http because I am sure port 9418 is blocked by the sysadmin
> 
> An good old access permission problem on the web server but I won't
> have time to sort it out now.

I had this same problem.  Turns out that for the http method of git, you
have to use the name 'www.linux-mips.org'.  So it would be 

git clone http://www.linux-mips.org/pub/scm/linux-malta.git linux-malta.git

>   cvs -d :pserver:anonymous@git.linux-mips.org:/pub/scm/linux.git co
>   -d linux-malta -P <branch>
> 
> Where <branch> is one of linux-2.0, linux-2.2, linux-2.4,
> MaltaRef_2_4, MaltaRef_2_6 and master - if your firewall allows port
> 2401 that is ...
> 
> But why are you still using the linux-malta repository?  Since ~ 5
> months it is no longer being updated and has effectivly been replaced
> with linux.git repository.  Of this repository there are also
> snapshots of all tagged versions available.

Good point.

Cheers,

a
