Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Sep 2002 19:20:32 +0200 (CEST)
Received: from opengraphics.com ([216.208.162.194]:59665 "EHLO
	hurricane.opengraphics.com") by linux-mips.org with ESMTP
	id <S1122961AbSI0RUc>; Fri, 27 Sep 2002 19:20:32 +0200
Received: from lsorense by hurricane.opengraphics.com with local (Exim 3.35 #1 (Debian))
	id 17uyml-0001uT-00; Fri, 27 Sep 2002 13:20:15 -0400
Date: Fri, 27 Sep 2002 13:20:15 -0400
To: Alex deVries <adevries@linuxcare.com>
Cc: Florian Lohoff <flo@rfc822.org>, linux-mips@linux-mips.org,
	debian-mips@lists.debian.org
Subject: Re: Format of bootable Indy CDs?
Message-ID: <20020927172015.GI17028@opengraphics.com>
References: <3D92B80A.3080802@linuxcare.com> <20020927160000.GB622@paradigm.rfc822.org> <3D9485C8.90301@linuxcare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D9485C8.90301@linuxcare.com>
User-Agent: Mutt/1.3.28i
From: Len Sorensen <lsorense@opengraphics.com>
X-Scanner: exiscan *17uyml-0001uT-00*cQpEiE9uFLQ* (OpenGraphics Corp, Toronto, Canada)
Return-Path: <lsorense@opengraphics.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 289
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lsorense@opengraphics.com
Precedence: bulk
X-list: linux-mips

On Fri, Sep 27, 2002 at 12:22:32PM -0400, Alex deVries wrote:
> Cool! As soon as I can find a 512-byte ro CDROM, I'll try this.
> 
> I've got part of mkefs working, BTW, which I realize is not required to 
> make bootable CDs, but might be helpful anyway.

Any plextor scsi drive should do.  It has a jumper to enable 512byte
block access.  They can be bought for fairly cheap for read only drives.

Len Sorensen
