Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2005 14:37:57 +0100 (BST)
Received: from smtp.wicomtechnologies.com ([IPv6:::ffff:195.234.214.162]:2761
	"EHLO smtp.wicomtechnologies.com") by linux-mips.org with ESMTP
	id <S8225296AbVGVNhe>; Fri, 22 Jul 2005 14:37:34 +0100
Received: from JERRY ([192.168.0.60])
	by smtp.wicomtechnologies.com (8.12.10/8.12.10) with ESMTP id j6MDdVlG054300
	for <linux-mips@linux-mips.org>; Fri, 22 Jul 2005 16:39:31 +0300 (EEST)
	(envelope-from jerry@wicomtechnologies.com)
Date:	Fri, 22 Jul 2005 16:39:29 +0300
From:	Jerry <jerry@wicomtechnologies.com>
X-Mailer: The Bat! (v3.0.1.33) Professional
Reply-To: Jerry <jerry@wicomtechnologies.com>
X-Priority: 3 (Normal)
Message-ID: <1663025994.20050722163929@wicomtechnologies.com>
To:	linux-mips@linux-mips.org
Subject: structure initialization
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <jerry@wicomtechnologies.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8603
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jerry@wicomtechnologies.com
Precedence: bulk
X-list: linux-mips


A kind of lame offtopic question :)
What reason in 2.6 to do structure init in this way:
 struct a = {
  .name = value
...

instead of 2.4-like:
 struct a = {
  name: value
...

Is this a bad form to use ".name" in 2.4 or "name:" in 2.6?


   ()_()
 -( ^,^ )- -[21398845]- -<The Bat! 3.0.1.33>- -<22.07.2005 16:27>-
  (") (")
