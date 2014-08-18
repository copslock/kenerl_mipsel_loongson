Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Aug 2014 15:59:55 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45088 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6855205AbaHRN7lYlVhw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Aug 2014 15:59:41 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D8D0E565F7517;
        Mon, 18 Aug 2014 14:59:31 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 18 Aug 2014 14:59:34 +0100
Received: from localhost (192.168.154.158) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Mon, 18 Aug
 2014 14:59:33 +0100
Date:   Mon, 18 Aug 2014 14:59:33 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <stable@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>
Subject: [request for stable inclusion] MIPS: math-emu: Fix instruction
 decoding
Message-ID: <20140818135933.GA1214@mchandras-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.158]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42131
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

Hi Greg,

Could you please apply the following patch to the 3.16.X stable kernels?

c3b9b945e02e011c63522761e91133ea43eb6939
"MIPS: math-emu: Fix instruction decoding"

Thank you

-- 
markos
