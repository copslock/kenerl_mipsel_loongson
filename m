Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Oct 2002 14:51:57 +0200 (CEST)
Received: from p508B51F7.dip.t-dialin.net ([80.139.81.247]:58801 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1123897AbSJEMv4>; Sat, 5 Oct 2002 14:51:56 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g95CpiW31720;
	Sat, 5 Oct 2002 14:51:44 +0200
Date: Sat, 5 Oct 2002 14:51:42 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Kip Walker <kwalker@broadcom.com>
Cc: linux-mips@linux-mips.org
Subject: Re: do_ri and EPC adjustment
Message-ID: <20021005145142.A31477@linux-mips.org>
References: <3D9E10DF.C4C305B2@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D9E10DF.C4C305B2@broadcom.com>; from kwalker@broadcom.com on Fri, Oct 04, 2002 at 03:06:23PM -0700
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 379
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 04, 2002 at 03:06:23PM -0700, Kip Walker wrote:

> Sorry if this has already been discussed, but why does do_ri() adjust
> the EPC in compute_return_epc() before delivering the SIGILL to a user
> process?

The original reason was to avoid having knowledge weather to skip over an
instruction or not from the signal return path.  For various reasons this
seems a wrong decission.

  Ralf
