Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Oct 2004 20:04:44 +0100 (BST)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:45583 "EHLO
	penguin.netx4.com") by linux-mips.org with ESMTP
	id <S8225201AbUJNTEj>; Thu, 14 Oct 2004 20:04:39 +0100
Received: from [192.168.253.28] (tibook.embeddededge.com [192.168.253.28])
	by penguin.netx4.com (8.12.8/8.12.9) with ESMTP id i9EIuUb0029344;
	Thu, 14 Oct 2004 14:56:33 -0400
In-Reply-To: <447121BB-1DE7-11D9-8FE5-003065F9B7DC@embeddededge.com>
References: <20041014115304.3edbe141.toch@dfpost.ru> <447121BB-1DE7-11D9-8FE5-003065F9B7DC@embeddededge.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <16D02E43-1E14-11D9-AFCC-003065F9B7DC@embeddededge.com>
Content-Transfer-Encoding: 7bit
Cc: Dmitriy Tochansky <toch@dfpost.ru>, linux-mips@linux-mips.org
From: Dan Malek <dan@embeddededge.com>
Subject: Re: Strange instruction
Date: Thu, 14 Oct 2004 15:06:01 -0400
To: Dan Malek <dan@embeddededge.com>
X-Mailer: Apple Mail (2.619)
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6045
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips


On Oct 14, 2004, at 9:45 AM, Dan Malek wrote:

> The Au1xxx is schizophrenic about the way it handles endianness.

I guess I need to apologize for my choice of words as some people
thought this implied something negative about this processor and
better describe what is likely happening here.

Tell me more details about exactly where you see this code in the
boot rom and what kind of boot rom you are using.  My comments
about the core start up and bus controller endian modes are
still valid, and in some cases there may be byte swapped code
depending upon the core/bus modes (they are separately
software configurable).  Just consider that when disassembling
instructions in the rom.

Thanks.


	-- Dan
