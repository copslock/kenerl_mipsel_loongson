Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Apr 2014 18:01:58 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.114]:47277 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822429AbaDXQBxGPuj6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 Apr 2014 18:01:53 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 20F6280954071
        for <linux-mips@linux-mips.org>; Thu, 24 Apr 2014 17:01:43 +0100 (IST)
Received: from BAMAIL02.ba.imgtec.org (192.168.66.28) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Thu, 24 Apr 2014 17:01:45 +0100
Received: from [192.168.159.43] (192.168.159.43) by bamail02.ba.imgtec.org
 (192.168.66.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 24 Apr
 2014 09:01:43 -0700
Message-ID: <53593563.9030904@imgtec.com>
Date:   Thu, 24 Apr 2014 11:01:39 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
MIME-Version: 1.0
To:     LMOL <linux-mips@linux-mips.org>
Subject: Broken patch for LONG_LONG_MAX.
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.159.43]
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

Ralf,

In commit e80016dd6b2805339b6b5e2a2ea6d49ab9fa25b6 you deleted checking
for LONG_LONG_MAX which breaks on newer toolchains using the gcc-4.8.x
compilers. Might I suggest usage of LLONG_MAX instead? Thanks.

Steve
