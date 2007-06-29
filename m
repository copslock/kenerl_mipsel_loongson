Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jun 2007 03:03:56 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:18849 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20022876AbXF2CDv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 29 Jun 2007 03:03:51 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id D12F98AD8C;
	Fri, 29 Jun 2007 02:03:13 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Fri, 29 Jun 2007 02:03:13 +0000 (UTC)
Received: from [192.168.7.26] ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 28 Jun 2007 19:03:12 -0700
Message-ID: <4684685E.4090805@avtrex.com>
Date:	Thu, 28 Jun 2007 19:03:10 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.12 (X11/20070530)
MIME-Version: 1.0
To:	"Ratin Rahman (mratin)" <mratin@cisco.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: upgrading glibc for mipsel
References: <cda58cb80706260820y4db3eacnae4dff0101852d52@mail.gmail.com> <20070627.013312.25479645.anemo@mba.ocn.ne.jp> <20070627153932.GA6016@lst.de> <20070628.112223.96686654.nemoto@toshiba-tops.co.jp> <20070628083725.GA23394@lst.de> <27801B4D04E7CA45825B0E0CE60FE10A0410F0D6@xmb-sjc-237.amer.cisco.com> <46842B05.5050103@avtrex.com> <27801B4D04E7CA45825B0E0CE60FE10A01F971CF@xmb-sjc-237.amer.cisco.com>
In-Reply-To: <27801B4D04E7CA45825B0E0CE60FE10A01F971CF@xmb-sjc-237.amer.cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Jun 2007 02:03:12.0365 (UTC) FILETIME=[A5D2A1D0:01C7B9F1]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15572
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Ratin Rahman (mratin) wrote:
> In an effort to build gdbserver, I am trying to upgrade my glibc and 
> gcc cross compile tools. I am  having
> problem while bulding glibc-2.3.3, mipsel compiler version 3.2.3 and 
> current glibc ver
> is 2.2.5.
>  

Stock glibc-2.3.3 will not work on mipsel-linux.  I posted the patch I 
use few years ago to this list.  You could try with that patch.  Or look 
at the cross-tool project.  Some people have had success using it to 
build toolchains.

David Daney
