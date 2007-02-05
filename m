Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Feb 2007 09:09:50 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.227]:28631 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20037425AbXBEJJq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Feb 2007 09:09:46 +0000
Received: by qb-out-0506.google.com with SMTP id e12so499311qba
        for <linux-mips@linux-mips.org>; Mon, 05 Feb 2007 01:08:44 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n2snF/qZM4EW3WYzk0lQdxadWFJ3V15aylBEoYZ+h7NjyLDny71deSI+3PrBLIA7n25G4wSamOmrXriXK06rpgnAUaMpQ/t9PXCqq6vPRFqg5JBKDPgepxR33Dda+4NArhj7OP6BRiaxhMxQTwlf+x2PcUDqN4CSVaqVNxqpZYE=
Received: by 10.115.76.1 with SMTP id d1mr571824wal.1170666523584;
        Mon, 05 Feb 2007 01:08:43 -0800 (PST)
Received: by 10.114.136.11 with HTTP; Mon, 5 Feb 2007 01:08:43 -0800 (PST)
Message-ID: <cda58cb80702050108x7c0ec65dxd8769f8515c45f34@mail.gmail.com>
Date:	Mon, 5 Feb 2007 10:08:43 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: Question about signal syscalls !
Cc:	"Daniel Jacobowitz" <dan@debian.org>,
	"David Daney" <ddaney@avtrex.com>,
	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <20070205011048.GA26654@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070201135734.GB12728@linux-mips.org>
	 <45C21CFE.9060804@avtrex.com>
	 <cda58cb80702020055t6eb2578fn5d1e4370e9ebda08@mail.gmail.com>
	 <45C3611D.7000702@avtrex.com>
	 <cda58cb80702020836t54ab54bam1b83dd7c1dacb4d8@mail.gmail.com>
	 <45C36D46.5040409@avtrex.com>
	 <cda58cb80702021158n42bdb5fbi6cca4f2c8dff6782@mail.gmail.com>
	 <45C3A1E3.8010802@avtrex.com> <20070205005516.GA1581@nevyn.them.org>
	 <20070205011048.GA26654@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 2/5/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> Not saving the s-registers into the signal frame would be a neat
> optimization.  It wouldn't only make things a little faster it would

Actually it seems to me that setup_sigcontext() is almost completly
useless if the signal handler is dealt when returning from a system
call since just a very few registers are saved in the 'struct pt_regs'
structure. So setup_sigcontext() ends up saving a lot of random
values.
-- 
               Franck
