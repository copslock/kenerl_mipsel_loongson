Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Oct 2003 19:22:35 +0100 (BST)
Received: from [IPv6:::ffff:217.157.19.70] ([IPv6:::ffff:217.157.19.70]:21253
	"EHLO jehova.dsm.dk") by linux-mips.org with ESMTP
	id <S8225428AbTJMSWX>; Mon, 13 Oct 2003 19:22:23 +0100
Received: (qmail 26856 invoked from network); 13 Oct 2003 18:22:20 -0000
Received: from cpc5-cmbg1-3-0-cust166.cmbg.cable.ntl.com (HELO home.horsten.com) (@81.100.89.166)
  by server14.dsm.dk with RC4-MD5 encrypted SMTP; 13 Oct 2003 18:22:20 -0000
From: Thomas Horsten <thomas@horsten.com>
To: "Liu Hongming (Alan)" <alanliu@trident.com.cn>,
	linux-mips@linux-mips.org
Subject: Re: need help on unaligned loads,stores!
Date: Mon, 13 Oct 2003 19:27:07 +0100
User-Agent: KMail/1.5.4
References: <15F9E1AE3207D6119CEA00D0B7DD5F6801AC0B85@TMTMS>
In-Reply-To: <15F9E1AE3207D6119CEA00D0B7DD5F6801AC0B85@TMTMS>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310131927.07171.thomas@horsten.com>
Return-Path: <thomas@horsten.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas@horsten.com
Precedence: bulk
X-list: linux-mips

On Monday 13 October 2003 02:44, Liu Hongming (Alan) wrote:

> I am porting linux for a cpu that doesnt support unaligned loads/stores
> instructions.
>
> when using memcpy in arch/mips/memcpy.S,it will not work on these
> instructions.
>
> Any one could help me to deal with this? Have you ever ported linux for
> this kind cpu?
>
> And anyone could tell me which cpu doesnt support these instructions
> either,and has
>
> been ported for linux?

Almost all MIPS CPU's are like this, and don't support unaligned accesses.

The memcpy in arch/mips/lib/memcpy.S already handles this (by copying the end 
and beginning using byte-accesses if not aligned).

Best regards,

Thomas
