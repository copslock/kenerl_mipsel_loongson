Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jun 2008 10:36:27 +0100 (BST)
Received: from mx.mips.com ([63.167.95.198]:50913 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S20039894AbYFKJfM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Jun 2008 10:35:12 +0100
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id m5B9XgXo014244;
	Wed, 11 Jun 2008 02:33:42 -0700 (PDT)
Received: from [127.0.0.1] (grendel [192.168.236.16])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id m5B9YIYo029524;
	Wed, 11 Jun 2008 02:34:34 -0700 (PDT)
Message-ID: <484F9C76.4030104@mips.com>
Date:	Wed, 11 Jun 2008 11:35:50 +0200
From:	"Kevin D. Kissell" <kevink@mips.com>
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	"Kevin D. Kissell" <KevinK@paralogos.com>,
	Brian Foster <brian.foster@innova-card.com>,
	linux-mips@linux-mips.org, Andrew Dyer <adyer@righthandtech.com>
Subject: Re: Adding(?) XI support to MIPS-Linux?
References: <200806091658.10937.brian.foster@innova-card.com> <a537dd660806090837i5ef6c1e2k167aeb97785a136d@mail.gmail.com> <484D856B.5030306@paralogos.com> <20080611090601.GB19755@linux-mips.org>
In-Reply-To: <20080611090601.GB19755@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Mon, Jun 09, 2008 at 09:32:59PM +0200, Kevin D. Kissell wrote:
>
>   
>> That is correct, though there has long been interest in having XI/RI as an option for non-SmartMIPS cores and I would not be surprised if sooner or later it became more generally available.
>>     
>
> Cavium has it in their 64-bit core.  I haven't verified this in the docs
> but apparently it is meant to be compatible with the old SmartMIPS ASE
> for MIPS32.
>   
Do check the documentation.  I can't comment officially, but I can 
observe that,
in the hypothetical case where you'd want XI/RI semantics in a 64-bit 
processor,
you might use exactly the same semantics (and therefore the same kernel 
C code
support), but you might want to use different bits  for XI/RI in a 
64-bit TLB entry
than in a 32-bit TLB entry (and therefore different header file 
definitions).

          Regards,

          Kevin K.
