Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2003 07:18:59 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:45306 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225296AbTJVGS5>;
	Wed, 22 Oct 2003 07:18:57 +0100
Received: from [10.2.2.20] (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id XAA22922;
	Tue, 21 Oct 2003 23:18:48 -0700
Subject: Re: Is Yamon executed in flash or in RAM?
From: Pete Popov <ppopov@mvista.com>
To: taoyong2002cncq@yahoo.com.cn
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <20031022061346Z8225296-1272+8254@linux-mips.org>
References: <20031022061346Z8225296-1272+8254@linux-mips.org>
Content-Type: text/plain
Organization: 
Message-Id: <1066803540.28777.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 21 Oct 2003 23:19:07 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3478
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, 2003-10-21 at 23:16, taoyong wrote:
> hi,
>    
>     Have anyone used the YAMON on PB1000? 
>     I wonder whether it is executed in flash or in RAM.

Boots from flash, moves to RAM, and runs out of RAM.

Pete
