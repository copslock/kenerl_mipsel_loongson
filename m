Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2004 17:13:24 +0000 (GMT)
Received: from p508B5CC5.dip.t-dialin.net ([IPv6:::ffff:80.139.92.197]:18014
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225217AbUBYRNX>; Wed, 25 Feb 2004 17:13:23 +0000
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i1PHDLex018869;
	Wed, 25 Feb 2004 18:13:21 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i1PHDFRb018868;
	Wed, 25 Feb 2004 18:13:15 +0100
Date: Wed, 25 Feb 2004 18:13:15 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Liu Hongming (Alan)" <alanliu@trident.com.cn>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-mips@linux-mips.org
Subject: Re: IDE driver problem
Message-ID: <20040225171315.GB17217@linux-mips.org>
References: <15F9E1AE3207D6119CEA00D0B7DD5F680219C882@TMTMS>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15F9E1AE3207D6119CEA00D0B7DD5F680219C882@TMTMS>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4440
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 25, 2004 at 08:11:54PM +0800, Liu Hongming (Alan) wrote:

> I have found out where the problem is. Since my hardware has
> endian issue, fs/partition/msdos.c could not handle partition table
> correctly. I have changed a little(still having much to change),and it 
> really works now.

I'm not sure what you call endian issue here.  The PC style partition
table code we've used for years on big endian systems without problems.

  Ralf
