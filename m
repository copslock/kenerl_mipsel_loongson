Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Aug 2004 23:08:47 +0100 (BST)
Received: from mx2.redhat.com ([IPv6:::ffff:66.187.237.31]:3033 "EHLO
	mx2.redhat.com") by linux-mips.org with ESMTP id <S8225002AbUHIWIn>;
	Mon, 9 Aug 2004 23:08:43 +0100
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.12.10/8.12.10) with ESMTP id i79LX0fu008535;
	Mon, 9 Aug 2004 17:33:00 -0400
Received: from potter.sfbay.redhat.com (potter.sfbay.redhat.com [172.16.27.15])
	by int-mx2.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i79M8dX09238;
	Mon, 9 Aug 2004 18:08:39 -0400
Received: from frothingslosh.sfbay.redhat.com (frothingslosh.sfbay.redhat.com [172.16.24.27])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id i79M8cV29153;
	Mon, 9 Aug 2004 15:08:38 -0700
Received: from frothingslosh.sfbay.redhat.com (localhost.localdomain [127.0.0.1])
	by frothingslosh.sfbay.redhat.com (8.12.10/8.12.10) with ESMTP id i79M8cOo016798;
	Mon, 9 Aug 2004 15:08:38 -0700
Received: (from rth@localhost)
	by frothingslosh.sfbay.redhat.com (8.12.10/8.12.10/Submit) id i79M8c8X016796;
	Mon, 9 Aug 2004 15:08:38 -0700
X-Authentication-Warning: frothingslosh.sfbay.redhat.com: rth set sender to rth@redhat.com using -f
Date: Mon, 9 Aug 2004 15:08:38 -0700
From: Richard Henderson <rth@redhat.com>
To: Richard Sandiford <rsandifo@redhat.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Nigel Stephens <nigel@mips.com>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org
Subject: Re: [patch] MIPS/gcc: Revert removal of DImode shifts for 32-bit targets
Message-ID: <20040809220838.GE16493@redhat.com>
Mail-Followup-To: Richard Henderson <rth@redhat.com>,
	Richard Sandiford <rsandifo@redhat.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Nigel Stephens <nigel@mips.com>, gcc-patches@gcc.gnu.org,
	linux-mips@linux-mips.org
References: <20040723202703.GB30931@redhat.com> <20040723211232.GB5138@linux-mips.org> <Pine.LNX.4.58L.0407261325470.3873@blysk.ds.pg.gda.pl> <410E9E25.7080104@mips.com> <87acxcbxfl.fsf@redhat.com> <410F5964.3010109@mips.com> <876580bm2e.fsf@redhat.com> <410F60DF.9020400@mips.com> <Pine.LNX.4.58L.0408042123030.31930@blysk.ds.pg.gda.pl> <87r7qiwz54.fsf@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r7qiwz54.fsf@redhat.com>
User-Agent: Mutt/1.4.1i
Return-Path: <rth@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5615
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rth@redhat.com
Precedence: bulk
X-list: linux-mips

On Sat, Aug 07, 2004 at 08:01:43PM +0100, Richard Sandiford wrote:
> +   do_compare_rtx_and_jump (cmp1, cmp2, cmp_code, true, op1_mode,
> + 			   0, 0, subword_label);
> + 
> +   if (!expand_superword_shift (op1_mode, binoptab,
> + 			       outof_input, op1,
> + 			       outof_target, into_target,
> + 			       unsignedp, methods))
> +     return false;

Return without cleaning up the branch emitted?  In particular,
doing so without emitting the labels will result in ICEs.



r~
