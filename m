Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Oct 2004 13:17:12 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:30220 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225195AbUJNMRI>;
	Thu, 14 Oct 2004 13:17:08 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1CI4gY-00047R-00; Thu, 14 Oct 2004 13:26:22 +0100
Received: from shoreditch-home.algor.co.uk ([172.20.192.99])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1CI4XL-0003B0-00; Thu, 14 Oct 2004 13:16:51 +0100
Message-ID: <416E6E32.5080009@mips.com>
Date: Thu, 14 Oct 2004 13:16:50 +0100
From: Nigel Stephens <nigel@mips.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
CC: "Kevin D. Kissell" <kevink@mips.com>,
	Dmitriy Tochansky <toch@dfpost.ru>, linux-mips@linux-mips.org
Subject: Re: Strange instruction
References: <20041014115304.3edbe141.toch@dfpost.ru> <01d901c4b1c8$996b7b30$10eca8c0@grendel> <20041014121242.GA1398@rembrandt.csv.ica.uni-stuttgart.de>
In-Reply-To: <20041014121242.GA1398@rembrandt.csv.ica.uni-stuttgart.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.816, required 4, AWL,
	BAYES_00)
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6034
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips



Thiemo Seufer wrote:

>
>
>GNU as has "move" as builtin macro which is expanded differently for
>32 and 64 bit mode. This simplifies the task of writing code for both
>models. Unfortunately the expansion was broken for a while and
>generated always the 64 bit version if the toolchain was 64bit
>_capable_. IIRC this was fixed in the early 2.14 timeframe.
>
>
>  
>

Wouldn't it be safer, as Kevin suggests, for the "move" macro to 
generate "or $rd,$0,$rs", since that will work correctly in either mode?

Nigel

>  
>
