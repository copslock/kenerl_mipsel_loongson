Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 May 2011 00:01:29 +0200 (CEST)
Received: from lebrac.rtp-net.org ([88.191.135.105]:55267 "EHLO
        lebrac.rtp-net.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491878Ab1EMWBY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 14 May 2011 00:01:24 +0200
Received: by lebrac.rtp-net.org (Postfix, from userid 5001)
        id 534D929266; Sat, 14 May 2011 00:00:52 +0200 (CEST)
Received: from lebrac.rtp-net.org (localhost [IPv6:::1])
        by lebrac.rtp-net.org (Postfix) with ESMTP id 460FF291D3;
        Sat, 14 May 2011 00:00:50 +0200 (CEST)
From:   Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     "Jayachandran C." <jayachandranc@netlogicmicro.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] MIPS: Replace _PAGE_READ with _PAGE_NO_READ
Organization: RtpNet
References: <7aa38c32b7748a95e814e5bb0583f967@localhost>
        <20110513150707.GA26389@linux-mips.org>
        <BANLkTikcyEzjOWt9pWToE=89dySSEYbw_g@mail.gmail.com>
        <20110513155605.GA30674@linux-mips.org>
        <BANLkTinnALQV6dXkJ0AjaQ1=bTawYMMkuQ@mail.gmail.com>
        <20110513173633.GA14607@jayachandranc.netlogicmicro.com>
        <BANLkTim+z7TSCvNA2duA6LsUzNsiu9OQaQ@mail.gmail.com>
        <20110513184532.GC14607@jayachandranc.netlogicmicro.com>
        <4DCD7F1A.3040904@caviumnetworks.com>
Date:   Sat, 14 May 2011 00:00:50 +0200
In-Reply-To: <4DCD7F1A.3040904@caviumnetworks.com> (David Daney's message of
        "Fri, 13 May 2011 11:57:30 -0700")
Message-ID: <87aaeqs1kd.fsf@lebrac.rtp-net.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <arnaud.patard@rtp-net.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30019
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnaud.patard@rtp-net.org
Precedence: bulk
X-list: linux-mips

d
