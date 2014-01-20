Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jan 2014 00:10:10 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:37129 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827345AbaATXKIhpEPb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Jan 2014 00:10:08 +0100
From:   DengCheng Zhu <DengCheng.Zhu@imgtec.com>
To:     John Crispin <john@phrozen.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH upstream-sfr] MIPS: APRP: Use the new __wait_event*()
 interface in RTLX
Thread-Topic: [PATCH upstream-sfr] MIPS: APRP: Use the new __wait_event*()
 interface in RTLX
Thread-Index: AQHPEwMWbV3qOJ4cUE20+Qy8RV5o4ZqJB4GAgAAmO4CABRWZSA==
Date:   Mon, 20 Jan 2014 23:09:53 +0000
Message-ID: <1F7D814BDD93B94493CEE724A97FB4DC4C8D2AC0@BADAG02.ba.imgtec.org>
References: <1389908212-19898-1-git-send-email-dengcheng.zhu@imgtec.com>
 <52D8D83F.1020906@phrozen.org>,<52D968D1.2040309@imgtec.com>
In-Reply-To: <52D968D1.2040309@imgtec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.64.117]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SEF-Processed: 7_3_0_01192__2014_01_20_23_10_00
Return-Path: <DengCheng.Zhu@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39034
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: DengCheng.Zhu@imgtec.com
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

Hi John,


I'm re-sending my last message below to make sure you receive it, because neither the LMO mailing list archive nor the patchwork shows my following reply. Curious how come the ad spams frequently make themselves show up successfully :-(

My last message:

> That's OK to me.


Deng-Cheng




From: Deng-Cheng Zhu [dengcheng.zhu@imgtec.com]

Sent: Friday, January 17, 2014 9:30 AM

To: John Crispin; linux-mips@linux-mips.org

Subject: Re: [PATCH upstream-sfr] MIPS: APRP: Use the new __wait_event*() interface in RTLX









That's OK to me.





Deng-Cheng

 







From: 
John Crispin

Sent: Thursday, January 16, 2014 11:14PM

To: 
Deng-Cheng Zhu, 
linux-mips

Subject: Re: [PATCH upstream-sfr] MIPS: APRP: Use the new __wait_event*() interface in RTLX




Hi,

should we fold this fix into 9d4147a783


    John

 
On 16/01/2014 22:36, Deng-Cheng Zhu wrote:


From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>

The commit 35a2af94c7 (sched/wait: Make the __wait_event*() interface more
friendly) changed __wait_event_interruptible() to use 2 parameters instead
of 3. It also made corresponding changes to rtlx.c. However, these changes
were partially reverted by 9d4147a783 (MIPS: APRP: Code formatting
clean-ups.). This patch fixes it.

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
---
Ralf, this needs to go upstream-sfr/mips-for-linux-next to fix the APRP
build error: macro "__wait_event_interruptible" passed 3 arguments, but
takes just 2

 arch/mips/kernel/rtlx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/rtlx.c b/arch/mips/kernel/rtlx.c
index 4658350..31b1b76 100644
--- a/arch/mips/kernel/rtlx.c
+++ b/arch/mips/kernel/rtlx.c
@@ -108,10 +108,9 @@ int rtlx_open(int index, int can_sleep)
 		p = vpe_get_shared(aprp_cpu_index());
 		if (p == NULL) {
 			if (can_sleep) {
-				__wait_event_interruptible(
+				ret = __wait_event_interruptible(
 					channel_wqs[index].lx_queue,
-					(p = vpe_get_shared(aprp_cpu_index())),
-					ret);
+					(p = vpe_get_shared(aprp_cpu_index())));
 				if (ret)
 					goto out_fail;
 			} else {
