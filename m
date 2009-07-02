Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jul 2009 04:15:43 +0200 (CEST)
Received: from mail-yx0-f183.google.com ([209.85.210.183]:64032 "EHLO
	mail-yx0-f183.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491983AbZGBCPf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Jul 2009 04:15:35 +0200
Received: by yxe13 with SMTP id 13so2056394yxe.22
        for <multiple recipients>; Wed, 01 Jul 2009 19:09:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KREtBvwPX95nV0FGVeLJLXCxgj2OAq7XBEd8/pj+y5M=;
        b=CmsQMfgeGIIrl8wxXZHiRMGsS/0NtJoD4/3S0c3IH/jJ2WGLzbL8Bu4osJOd3OrYOJ
         Q2SmozQIXkvg/7TiiDwGN/5cDb5vt2MTNRox1V4eHy6vAM15wfPjLKC8BVy8qQK38J1h
         i80Eyn2yv+JlnrPS0xKmpCbQC5KCUl6Tdf1qU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vB0YX826xDiUjFU2tjN7+kAo+4fsDePfooX77XAcyPQBgmlE3l3++E3o4fEX/AMelV
         lrEBgDWwBup5FyMrV4esEUfHjDE3PdLIw7jrYBYzHzLCfMY7Z7tbin2NZ8nH9Ru6bbta
         CC/ymDOiLrl1j5TTpb1fv5FwWzrYaxJNAGBp4=
MIME-Version: 1.0
Received: by 10.90.80.4 with SMTP id d4mr2063840agb.4.1246500594117; Wed, 01 
	Jul 2009 19:09:54 -0700 (PDT)
In-Reply-To: <1246499203.9660.52.camel@falcon>
References: <etTXaRqGgAC.A.SaE.6iASKB@chimera>
	 <1246459661.9660.40.camel@falcon>
	 <200907011821.26091.bzolnier@gmail.com>
	 <200907011829.16850.bzolnier@gmail.com>
	 <1246499203.9660.52.camel@falcon>
Date:	Thu, 2 Jul 2009 10:09:53 +0800
Message-ID: <b6a2187b0907011909l41b513fen3252ce00f7e4c9c9@mail.gmail.com>
Subject: Re: [Bug #13663] suspend to ram regression (IDE related)
From:	Jeff Chua <jeff.chua.linux@gmail.com>
To:	wuzhangjin@gmail.com
Cc:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Etienne Basset <etienne.basset@numericable.fr>,
	David Miller <davem@davemloft.net>, rjw@sisk.pl,
	linux-kernel@vger.kernel.org, kernel-testers@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	linux-ide@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <jeff.chua.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23591
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff.chua.linux@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, Jul 2, 2009 at 9:46 AM, Wu Zhangjin<wuzhangjin@gmail.com> wrote:
> it this too old? should i merge another git repository?
> I have tried to apply it manually, but unfortunately, also not work. any
> other patch needed?

You need to be undo those two patches below ...

> On Mon, Jun 29, 2009 at 11:51 PM, Etienne Basset<etienne.basset@numericable.fr>
> To have STR/resume work with current git, I have to :
> 1) apply Bart's patch
> 2) revert this commit : a1317f714af7aed60ddc182d0122477cbe36ee9b

or try to pull from Linus's tree and try again. Latest is now ...

commit d960eea974f5e500c0dcb95a934239cc1f481cfd
Author: Randy Dunlap <randy.dunlap@oracle.com>
Date:   Mon Jun 29 14:54:11 2009 -0700

    kernel-doc: move ignoring kmemcheck



Jeff.
