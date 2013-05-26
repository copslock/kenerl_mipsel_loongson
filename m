Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 May 2013 10:46:12 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46487 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6820504Ab3EZIqKWYCop (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 26 May 2013 10:46:10 +0200
Date:   Sun, 26 May 2013 09:46:10 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Tony Wu <tung7970@gmail.com>
cc:     Ralf Baechle <ralf@linux-mips.org>, Steven.Hill@imgtec.com,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: microMIPS: Refactor mips16 get_frame_info
 support
In-Reply-To: <alpine.LFD.2.03.1305252349290.18557@linux-mips.org>
Message-ID: <alpine.LFD.2.03.1305260944500.18557@linux-mips.org>
References: <20130525163216.GA5956@hades> <alpine.LFD.2.03.1305252349290.18557@linux-mips.org>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36601
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Sun, 26 May 2013, Maciej W. Rozycki wrote:

>  I think this:
> 
> > +		return (((ip->u_format.uimmediate >> 6) & mm_jalr_op) == mm_jalr_op);
> 
> should be fully decoded (and oversize line fixed too):
> 
> 		return (((ip->u_format.uimmediate >> 6) & ~0x14) == 
> 			mm_jalr_op);

 Self-correction here:

		return (((ip->u_format.uimmediate >> 6) & ~0x140) == 
			mm_jalr_op);

-- sorry about the mistake.

  Maciej
