Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Nov 2007 16:01:38 +0000 (GMT)
Received: from dmz.mips-uk.com ([194.74.144.194]:39941 "EHLO dmz.mips-uk.com")
	by ftp.linux-mips.org with ESMTP id S20030388AbXKEQBa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 5 Nov 2007 16:01:30 +0000
Received: from internal-mx1 ([192.168.192.240] helo=ukservices1.mips.com)
	by dmz.mips-uk.com with esmtp (Exim 3.35 #1 (Debian))
	id 1Ip4LD-00041K-00; Mon, 05 Nov 2007 15:58:19 +0000
Received: from ukcvpn18.mips-uk.com ([192.168.193.18])
	by ukservices1.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1Ip4L6-0002kv-00; Mon, 05 Nov 2007 15:58:12 +0000
Message-ID: <472F3D93.1070400@mips.com>
Date:	Mon, 05 Nov 2007 15:58:11 +0000
From:	Nigel Stephens <nigel@mips.com>
User-Agent: IceDove 1.5.0.12 (X11/20070607)
MIME-Version: 1.0
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
CC:	Thiemo Seufer <ths@networkno.de>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
References: <47126EDC.1060305@gmail.com> <20071014195324.GT3379@networkno.de> <4713C11F.3010903@gmail.com> <4713C958.8080805@mips.com> <47147551.1010004@gmail.com> <4714B58E.8020005@mips.com> <4715C039.7090603@gmail.com> <20071017123046.GY3379@networkno.de> <47160D31.5080201@mips.com> <472D8110.2080506@gmail.com> <20071104174710.GA9363@networkno.de> <472E2955.3000803@gmail.com>
In-Reply-To: <472E2955.3000803@gmail.com>
X-Enigmail-Version: 0.94.2.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MIPS-Technologies-UK-MailScanner: Found to be clean
X-MIPS-Technologies-UK-MailScanner-From: nigel@mips.com
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17405
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips



Franck Bui-Huu wrote:
> Thiemo Seufer wrote:
>   
>> Latest GCC upstream supports it (in SVN since 2007-07-05).
>>
>>     
>
> Good news although gcc 4.3 release is planed for end of January.
>   

Franck

A supported toolchain which now includes SmartMIPS support is the 
CodeSourcery MIPS Linux toolchain, based on gcc-4.2, see 
http://www.codesourcery.com/store/catalogue/c3/p17
> Is SDE gcc going to be obsolete after this release ?
>   

A pre-built "bare-iron" SDE configuration of GCC will probably continue 
to exist as part of the MIPS cross-development tools, but we are working 
to ensure that as many as possible of the SDE changes are available 
upstream for use by other Linux or GNU toolchain vendors, and/or those 
who wish to roll their own toolchain.

Nigel

-- 
Nigel Stephens    | 7200 Cambridge Research Park | t:[+44|0]1223 203110
MIPS Technologies | Cambridge, England  CB25 9TL | f:[+44|0]1223 203181
