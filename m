Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jan 2005 14:25:58 +0000 (GMT)
Received: from smtp2.wanadoo.fr ([IPv6:::ffff:193.252.22.29]:62829 "EHLO
	smtp2.wanadoo.fr") by linux-mips.org with ESMTP id <S8225305AbVAJOZs>;
	Mon, 10 Jan 2005 14:25:48 +0000
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0207.wanadoo.fr (SMTP Server) with ESMTP id 941521C0010D;
	Mon, 10 Jan 2005 15:25:42 +0100 (CET)
Received: from smtp.innova-card.com (AMarseille-206-1-6-143.w80-14.abo.wanadoo.fr [80.14.198.143])
	by mwinf0207.wanadoo.fr (SMTP Server) with ESMTP id 52F081C02292;
	Mon, 10 Jan 2005 15:25:42 +0100 (CET)
Received: from [192.168.0.24] (spoutnik.innova-card.com [192.168.0.24])
	by smtp.innova-card.com (Postfix) with ESMTP
	id 601213800C; Mon, 10 Jan 2005 15:25:34 +0100 (CET)
Message-ID: <41E29036.5040902@innova-card.com>
Date: Mon, 10 Jan 2005 15:24:54 +0100
From: Franck Bui-Huu <franck.bui-huu@innova-card.com>
Reply-To: franck.bui-huu@innova-card.com
Organization: Innova Card
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	linux-mips@linux-mips.org
Subject: Re: CPHYSADDR in setup.c
References: <41E26267.2090300@innova-card.com> <20050110135828.GB15344@rembrandt.csv.ica.uni-stuttgart.de>
In-Reply-To: <20050110135828.GB15344@rembrandt.csv.ica.uni-stuttgart.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <franck.bui-huu@innova-card.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: franck.bui-huu@innova-card.com
Precedence: bulk
X-list: linux-mips

Hi Thiemo

Thiemo Seufer wrote:

>That place in setup.c _had_ virt_to_phys before. It fails to build
>for 64bit code in 32bit objects with reasonably modern toolchains
>(which means all 64bit kernels currently supported in CVS).
>
>  
>
yes, but can't we modify "virt_to_phys" or "__pa" directly instead of
adding some new uses of CPHYSADDR in setup.c

thanks,

    Franck
