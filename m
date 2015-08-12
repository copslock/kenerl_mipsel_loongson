Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Aug 2015 12:21:07 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3020 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010957AbbHLKVGMREvX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Aug 2015 12:21:06 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D0896D7D76EB
        for <linux-mips@linux-mips.org>; Wed, 12 Aug 2015 11:20:58 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 12 Aug 2015 11:21:00 +0100
Received: from [192.168.154.136] (192.168.154.136) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 12 Aug
 2015 11:21:00 +0100
To:     <linux-mips@linux-mips.org>
From:   Alex Smith <alex.smith@imgtec.com>
Subject: VDSO
Message-ID: <55CB1E0C.4070405@imgtec.com>
Date:   Wed, 12 Aug 2015 11:21:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.136]
Return-Path: <Alex.Smith@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48814
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex.smith@imgtec.com
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

Hi,

I'm intending to start work on a proper VDSO implementation for MIPS that can provide user implementations of gettimeofday() and such, as well as take over from the current signal return trampoline code.

Just wondering if there's anyone else who's doing any work towards this so we can avoid duplication of effort if so?

Thanks,
Alex
