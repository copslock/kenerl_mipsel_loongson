Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2004 19:54:45 +0000 (GMT)
Received: from hueytecuilhuitl.mtu.ru ([IPv6:::ffff:195.34.32.123]:63495 "HELO
	hueymiccailhuitl.mtu.ru") by linux-mips.org with SMTP
	id <S8225532AbUASTyp>; Mon, 19 Jan 2004 19:54:45 +0000
Received: from ppp158-154.dialup.mtu-net.ru (ppp158-154.dialup.mtu-net.ru [62.118.158.154])
	by hueymiccailhuitl.mtu.ru (Postfix) with ESMTP id A9B7818714E
	for <linux-mips@linux-mips.org>; Mon, 19 Jan 2004 22:54:41 +0300 (MSK)
	(envelope-from vksavl@cityline.ru)
Date: Mon, 19 Jan 2004 22:55:48 +0300
From: Pavel Kiryukhin <vksavl@cityline.ru>
X-Mailer: The Bat! (v1.60q)
Reply-To: Pavel Kiryukhin <vksavl@cityline.ru>
X-Priority: 3 (Normal)
Message-ID: <1852455000.20040119225548@cityline.ru>
To: linux-mips@linux-mips.org
Subject: sys32_sched_getaffinity
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <vksavl@cityline.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4046
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vksavl@cityline.ru
Precedence: bulk
X-list: linux-mips

Hi,

could anybody give some comments on the following code in 2.4.x -
2.6.1.

sys_sched_getaffinity [kernel/sched.c] on success returns the size of
cpumask_t, which is obviously positive value.

while

sys32_sched_getaffinity [arch/mips/kernel/linux32.c] expect 0 as
successful return from sys_sched_getaffinity.

Would
  if (ret > 0) {
be more correct than
  if (ret == 0) {
in sys32_sched_getaffinity?
-- 
Best regards,
 Pavel Kiryukhin                          mailto:vksavl@cityline.ru
