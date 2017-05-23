Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 May 2017 23:12:15 +0200 (CEST)
Received: from smtprelay0117.hostedemail.com ([216.40.44.117]:34619 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23994956AbdEWVMDcg2vv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 May 2017 23:12:03 +0200
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id A657123421;
        Tue, 23 May 2017 21:12:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: house07_85cef90357c08
X-Filterd-Recvd-Size: 1573
Received: from XPS-9350 (unknown [47.151.132.55])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Tue, 23 May 2017 21:11:59 +0000 (UTC)
Message-ID: <1495573909.2093.82.camel@perches.com>
Subject: Re: [PATCH 0/5] MIPS-kernel: Adjustments for some function
 implementations
From:   Joe Perches <joe@perches.com>
To:     SF Markus Elfring <elfring@users.sourceforge.net>,
        linux-mips@linux-mips.org, Ingo Molnar <mingo@kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Kees Cook <keescook@chromium.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Ralf =?ISO-8859-1?Q?B=E4chle?= <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Date:   Tue, 23 May 2017 14:11:49 -0700
In-Reply-To: <e866716c-5ce4-3658-f944-e310007db127@users.sourceforge.net>
References: <e866716c-5ce4-3658-f944-e310007db127@users.sourceforge.net>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.22.6-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57965
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
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

On Tue, 2017-05-23 at 22:50 +0200, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 23 May 2017 22:40:04 +0200
> 
> A few update suggestions were taken into account
> from static source code analysis.

Stop sending new patches until you handle the
feedback you receive on old patches.
