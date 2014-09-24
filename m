Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Sep 2014 14:08:33 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56996 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009593AbaIXMI23cuBk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Sep 2014 14:08:28 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9DABF3E5F269
        for <linux-mips@linux-mips.org>; Wed, 24 Sep 2014 13:08:18 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 24 Sep 2014 13:08:21 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 24 Sep
 2014 13:08:20 +0100
Message-ID: <5422B434.2020405@imgtec.com>
Date:   Wed, 24 Sep 2014 13:08:20 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH 04/11] MIPS: wrap cfcmsa & ctcmsa accesses for toolchains
 with MSA support
References: <1411551942-11153-1-git-send-email-paul.burton@imgtec.com> <1411551942-11153-5-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1411551942-11153-5-git-send-email-paul.burton@imgtec.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42768
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

On 24/09/14 10:45, Paul Burton wrote:
> and provide
> implementations for the TOOLCHAIN_SUPPORTS_MSA case which ".set msa" as
> appropriate.

nit: which *uses* ".set msa"?

Cheers
James
