Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jan 2005 19:36:05 +0000 (GMT)
Received: from alpha.total-knowledge.com ([IPv6:::ffff:209.157.135.102]:30668
	"EHLO alpha.total-knowledge.com") by linux-mips.org with ESMTP
	id <S8225341AbVAFTf6>; Thu, 6 Jan 2005 19:35:58 +0000
Received: (qmail 21761 invoked from network); 6 Jan 2005 02:22:43 -0800
Received: from c-24-6-216-150.client.comcast.net (HELO ?192.168.0.238?) (24.6.216.150)
  by alpha.total-knowledge.com with SMTP; 6 Jan 2005 02:22:43 -0800
Message-ID: <41DD9313.4030105@total-knowledge.com>
Date: Thu, 06 Jan 2005 11:35:47 -0800
From: "Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Organization: Total Knowledge
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041221
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	greg@kroah.com, Ladislav Michl <ladis@linux-mips.org>,
	linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com,
	linux-mips@linux-mips.org
Subject: Re: [2.6 patch] 2.6.10-mm2: let I2C_ALGO_SGI depend on MIPS
References: <20050106002240.00ac4611.akpm@osdl.org> <20050106181519.GG3096@stusta.de> <20050106192701.GA13955@linux-mips.org>
In-Reply-To: <20050106192701.GA13955@linux-mips.org>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ilya@total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6821
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@total-knowledge.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

>On Thu, Jan 06, 2005 at 07:15:20PM +0100, Adrian Bunk wrote:
>
>  
>
>>There's no reason for offering a MIPS-only driver on other architectures 
>>(even though it does compile).
>>
>>Even better dependencies on specific MIPS variables might be possible 
>>that obsolete this patch, but this patch fixes at least the !MIPS case.
>>    
>>
>
>Please make that depend on SGI_IP22 || SGI_IP32 instead; the only machines
>actually using it.
>
>Ladis, is VisWS using this algo also?
>  
>
Since MACE is common part, it most likely does.

>  Ralf
>
>  
>
