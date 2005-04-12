Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Apr 2005 19:28:19 +0100 (BST)
Received: from mx02.qsc.de ([IPv6:::ffff:213.148.130.14]:3809 "EHLO
	mx02.qsc.de") by linux-mips.org with ESMTP id <S8225204AbVDLS2E>;
	Tue, 12 Apr 2005 19:28:04 +0100
Received: from port-195-158-168-78.dynamic.qsc.de ([195.158.168.78] helo=hattusa.textio)
	by mx02.qsc.de with esmtp (Exim 3.35 #1)
	id 1DLQ77-0007t1-00; Tue, 12 Apr 2005 20:27:53 +0200
Received: from ths by hattusa.textio with local (Exim 4.50)
	id 1DLPVE-0007G3-Pl; Tue, 12 Apr 2005 19:48:44 +0200
Date:	Tue, 12 Apr 2005 19:48:44 +0200
To:	Christoph Hellwig <hch@lst.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
Message-ID: <20050412174844.GD12375@hattusa.textio>
References: <20050412140045Z8224988-1340+5602@linux-mips.org> <20050412165728.GA22407@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050412165728.GA22407@lst.de>
User-Agent: Mutt/1.5.8i
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7711
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Christoph Hellwig wrote:
> On Tue, Apr 12, 2005 at 03:00:38PM +0100, ths@linux-mips.org wrote:
> > 
> > CVSROOT:	/home/cvs
> > Module name:	linux
> > Changes by:	ths@ftp.linux-mips.org	05/04/12 15:00:38
> > 
> > Modified files:
> > 	drivers/scsi   : sgiwd93.c 
> > Removed files:
> > 	drivers/scsi   : sgiwd93.h 
> > 
> > Log message:
> > 	Enable proc support, minor code cleanup.
> 
> Haven't seen the diffs, but please don't add new ->proc_info methods.
> It's deprecated and will go away in the not very distant future.

The comments in scsi_host.s leave no doubt about that. :-)
The function isn't exactly new, the sgiwd driver reuses the generic
wd function.


Thiemo
