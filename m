Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Mar 2017 16:06:10 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:33704 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993904AbdCVPFjjfxpk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 Mar 2017 16:05:39 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v2MF5c4c018683;
        Wed, 22 Mar 2017 16:05:38 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v2MF5cL0018682;
        Wed, 22 Mar 2017 16:05:38 +0100
Date:   Wed, 22 Mar 2017 16:05:38 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc:     linux-mips@linux-mips.org, james.hogan@imgtec.com,
        paul.burton@imgtec.com, leonid.yegoshin@imgtec.com,
        douglas.leung@imgtec.com, aleksandar.markovic@imgtec.com,
        petar.jovanovic@imgtec.com, miodrag.dinic@imgtec.com,
        goran.ferenc@imgtec.com
Subject: Re: [PATCH 3/3] MIPS: math-emu: Fix BC1EQZ and BC1NEZ condition
 handling
Message-ID: <20170322150538.GD14889@linux-mips.org>
References: <1489419397-25291-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1489419397-25291-4-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1489419397-25291-4-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

Applied.  Thanks,

  Ralf
