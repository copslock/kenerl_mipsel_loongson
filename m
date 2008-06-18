Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jun 2008 10:35:56 +0100 (BST)
Received: from aux-209-217-49-36.oklahoma.net ([209.217.49.36]:64014 "EHLO
	proteus.paralogos.com") by ftp.linux-mips.org with ESMTP
	id S20026526AbYFRJfx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Jun 2008 10:35:53 +0100
Received: from [127.0.0.1] (cerberus.paralogos.fr [81.255.9.181])
	by proteus.paralogos.com (8.9.3/8.9.3) with ESMTP id FAA08029;
	Wed, 18 Jun 2008 05:06:51 -0500
Message-ID: <4858D735.5020406@paralogos.com>
Date:	Wed, 18 Jun 2008 11:36:53 +0200
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
MIME-Version: 1.0
To:	Brian Foster <brian.foster@innova-card.com>
CC:	linux-mips@linux-mips.org, David Daney <ddaney@avtrex.com>,
	Thiemo Seufer <ths@networkno.de>,
	Andrew Dyer <adyer@righthandtech.com>
Subject: Re: Adding(?) XI support to MIPS-Linux?
References: <200806091658.10937.brian.foster@innova-card.com> <484EAA16.80903@avtrex.com> <200806111516.57406.brian.foster@innova-card.com> <200806181042.12911.brian.foster@innova-card.com>
In-Reply-To: <200806181042.12911.brian.foster@innova-card.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19588
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

Brian Foster wrote:
>  Whilst thinking about the problem and possible solutions,
>  it occurred to me there could be a defect in the current
>  trampoline:  Suppose there is a signal, either at point A,
>  due to <instr> itself, or at point B, which is caught on
>  this stack, and the user-land signal-handler ‘return’s.
>
>  Doesn't the signal-handler/sigreturn stack-frame overwrite
>  the FP trampoline?   In which case, when the signal-hander
>  returns, more-or-less anything could happen.  (And very
>  unlikely to be what's wanted!)
>   
When I first integrated the FP emulator into the kernel, back in 2.2.x, 
I seem to
recall that someone found this problem and that I came up with a tweak 
to signal
stack setup that protected the FP branch delay slot trampoline.  Maybe 
I'm mistaken,
or maybe the tweak was lost?

          Regards,

          Kevin K.
