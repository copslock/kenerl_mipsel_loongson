Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 May 2017 22:53:56 +0200 (CEST)
Received: from mout.web.de ([212.227.15.3]:56312 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994941AbdEWUxtBKGov (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 23 May 2017 22:53:49 +0200
Received: from [192.168.1.2] ([78.49.50.198]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LzmLr-1e0PKM1VAJ-0155U4; Tue, 23
 May 2017 22:53:21 +0200
Subject: [PATCH 3/5] MIPS: VPE: Delete an error message for a failed memory
 allocation in vpe_open()
From:   SF Markus Elfring <elfring@users.sourceforge.net>
To:     linux-mips@linux-mips.org, Ingo Molnar <mingo@kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Kees Cook <keescook@chromium.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <e866716c-5ce4-3658-f944-e310007db127@users.sourceforge.net>
Message-ID: <94b1e14f-47c0-7f13-6158-700488d63c66@users.sourceforge.net>
Date:   Tue, 23 May 2017 22:53:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <e866716c-5ce4-3658-f944-e310007db127@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:B8o2fVhWeT8bDCkbIq+6baGM5VrByM++1yE61DH42MHHiJ8XcZd
 DhxZ/Htb96O+jNhOiRAm7FAjP87NIkTn6hzKP4iPnF6XKxkgNuJc+pG2xI4X8caAL6lAb2e
 peuL6TQjHus3ANttoSZ1PTOMmuyQMjJle3usO87+dn8/ijChRX6HHbzCpISO2+G+LQTYfs6
 58lMMCFQVoHvuPNqbakeQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:T0LR6qkqS0o=:7qHSDHojIlJiblebicEuDm
 RtiDb589wRk1qper1FL1DFBweNfBCRZxErIeYUJJRPDdtFLQIXVtKxst7GkslA95hu8u80maU
 M+/j6GVC4qNfseGetP02fZdKOaMld98EJWm1yF2KVchHVs/VjZmJ8WQgxsIpPUNeaoJO0Gjvl
 UVsDK8c4klXA9yS0NMijvbI+xzqbmJx47CkX+Gspgg6ER7Ha541EdWZ/95rdfAHtayqgYkFIU
 9qVNi184EuECWQn79xRrxfuvcYycWwalLOlKEm+1qESDYm442CJlVN1XStCivJ7gXHw6gfu5X
 1KwEucofYQ1QyZ8xX/eBjgY3y6fUZGHX611GSFNLT7rAvwW8b9VFKVFuH+01bJALiaZmXVXRt
 +5W3dpNFygu6ADpFaRPh/hGvbP2oDPXWzxHYHx73iKv16uIgizpimOJxa7sdXux6WP0kV2mcu
 MrPYYPXqmv4tqSkgNsJrETecC36yoRTyIRtbFkTt0wXavr/mQfPVyiD5LFoh0luy6hpOBCvCB
 mBP2kXVrTnBOsP3xjR0DhxWgRzxE8Drqsno0Brm+QcLnIoC3zYEtvC81RteNTkeJIj7vGiGJm
 1Jr9sml6YV9lr1lbNzr8yVoVtgEgCGW2tQ0FmxkWLGE++GcjrcZ6N/LQ8zroW8ZVb8wtGVYah
 y1V+zwsNiymYyC4dIyafwieTKH8OZf8DRLadXQEjBD47eJsVvOl6YhaZ9T3n/7mLyAnN8lKOR
 It8ydPOfm9kAJoVXkiCEalLM/RmIMHvrg9hg4aQLep17r3DbcKMdB3scrP6DWDr1XW1xNLJLU
 sHIcOMc
Return-Path: <elfring@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57961
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: elfring@users.sourceforge.net
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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 23 May 2017 21:54:42 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/mips/kernel/vpe.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
index 544ea21bfef9..721b1523b740 100644
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -799,7 +799,6 @@ static int vpe_open(struct inode *inode, struct file *filp)
-	if (!v->pbuffer) {
-		pr_warn("VPE loader: unable to allocate memory\n");
+	if (!v->pbuffer)
 		return -ENOMEM;
-	}
+
 	v->plen = P_SIZE;
 	v->load_addr = NULL;
 	v->len = 0;
-- 
2.13.0
