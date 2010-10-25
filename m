Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Oct 2010 23:33:04 +0200 (CEST)
Received: from tvwna-ip-c-172.princeton.org ([66.180.187.89]:58487 "EHLO
        localhost.m.enhanced.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491019Ab0JYVdC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Oct 2010 23:33:02 +0200
Received: from camm by localhost.m.enhanced.com with local (Exim 4.69)
        (envelope-from <camm@maguirefamily.org>)
        id 1PAUee-0002NN-5k; Mon, 25 Oct 2010 17:32:32 -0400
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     debian-mips@lists.debian.org,
        Frederick Isaac <freddyisaac@gmail.com>, gcl-devel@gnu.org,
        linux-mips <linux-mips@linux-mips.org>
Subject: gdb for mips64
References: <E1OwbkA-0006gv-Bi@localhost.m.enhanced.com>
        <4C93993E.7030008@caviumnetworks.com>
        <8762y49k1k.fsf@maguirefamily.org>
        <4C93D86D.5090201@caviumnetworks.com>
        <87fwx4dwu5.fsf@maguirefamily.org>
        <4C97D9A1.7050102@caviumnetworks.com>
        <87lj6te9t1.fsf@maguirefamily.org>
        <4C9A8BC9.1020605@caviumnetworks.com>
        <4C9A9699.6080908@caviumnetworks.com>
        <87pqvbs7oa.fsf@maguirefamily.org>
        <4CB88D2C.8020900@caviumnetworks.com>
        <87r5fksxby.fsf_-_@maguirefamily.org>
        <4CBF1B1E.6050804@caviumnetworks.com>
        <8762wwlfen.fsf@maguirefamily.org>
        <4CC06826.2070508@caviumnetworks.com>
        <4CC0787C.2040902@caviumnetworks.com>
From:   Camm Maguire <camm@maguirefamily.org>
Date:   Mon, 25 Oct 2010 17:32:32 -0400
In-Reply-To: <4CC0787C.2040902@caviumnetworks.com> (David Daney's message of "Thu\, 21 Oct 2010 10\:29\:32 -0700")
Message-ID: <878w1m3qmn.fsf_-_@maguirefamily.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <camm@maguirefamily.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28238
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: camm@maguirefamily.org
Precedence: bulk
X-list: linux-mips

Greetings!  Can gdb be made to work on mips64?

(gdb) r
Starting program: /home/camm/gcl-2.6.8pre/unixport/saved_pre_gcl 
/home/wingsun/develop/build/gdb/gdb-6.8/gdb/mips-tdep.c:603: internal-error: bad register size
A problem internal to GDB has been detected,
further debugging may prove unreliable.

Take care,
-- 
Camm Maguire			     		    camm@maguirefamily.org
==========================================================================
"The earth is but one country, and mankind its citizens."  --  Baha'u'llah
