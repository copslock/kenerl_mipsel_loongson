Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 May 2010 21:56:36 +0200 (CEST)
Received: from fg-out-1718.google.com ([72.14.220.156]:16339 "EHLO
        fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491969Ab0EWTwd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 23 May 2010 21:52:33 +0200
Received: by fg-out-1718.google.com with SMTP id 22so1361831fge.6
        for <multiple recipients>; Sun, 23 May 2010 12:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=lWaqGhqC/0klhY6YDVhtKfjfhk7I0sKD95sp0Oc/Fi4=;
        b=QmHEDS7EJgiBETOV6BEr14DeUEEWudQxLsaNYLmFFLFV7x6lCMk5a9O9n7cTK2ytcb
         aNEmCajgbQ2dL/IgNaTjAPHq3T7+C8tcgepw40yayQ8OEOP0HUajUQIAU/7VhiGsJMFA
         VvdDiWkP+HhiEcgalnN3fI3niV1rfSAWvqH4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=TQoL7SoRf0dEvvQLFSJxp6aux1s95p28jrZCSYedOfk/ztIDDNm8/tFDsa8NpVIX0d
         ZWJrFyddV3cdTfQ1UJl8O2xunHdZwO2YmWldK1D5mUkDebqZ/bvyx7UEv1Q35sPojT/F
         BFExCIgejrEQX35+bn30TuCiRhrYSupmj4BJo=
Received: by 10.87.2.15 with SMTP id e15mr7201089fgi.23.1274644353093;
        Sun, 23 May 2010 12:52:33 -0700 (PDT)
Received: from localhost.localdomain (net-93-145-200-9.t2.dsl.vodafone.it [93.145.200.9])
        by mx.google.com with ESMTPS id d6sm6081796fga.3.2010.05.23.12.52.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 May 2010 12:52:32 -0700 (PDT)
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     andrea.gelmini@gelma.net
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 171/199] arch/mips/sgi-ip27/ip27-klconfig.c: Checkpatch cleanup
Date:   Sun, 23 May 2010 21:52:12 +0200
Message-Id: <1274644332-23964-11-git-send-email-andrea.gelmini@gelma.net>
X-Mailer: git-send-email 1.7.1.251.gf80a2
In-Reply-To: <1274644332-23964-1-git-send-email-andrea.gelmini@gelma.net>
References: <1274644332-23964-1-git-send-email-andrea.gelmini@gelma.net>
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26817
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrea.gelmini@gelma.net
Precedence: bulk
X-list: linux-mips

arch/mips/sgi-ip27/ip27-klconfig.c:51: ERROR: "foo * bar" should be "foo *bar"
arch/mips/sgi-ip27/ip27-klconfig.c:63: ERROR: "foo * bar" should be "foo *bar"
arch/mips/sgi-ip27/ip27-klconfig.c:81: ERROR: "foo * bar" should be "foo *bar"
arch/mips/sgi-ip27/ip27-klconfig.c:100: ERROR: "foo * bar" should be "foo *bar"

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/mips/sgi-ip27/ip27-klconfig.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/sgi-ip27/ip27-klconfig.c b/arch/mips/sgi-ip27/ip27-klconfig.c
index dd830b3..7afe146 100644
--- a/arch/mips/sgi-ip27/ip27-klconfig.c
+++ b/arch/mips/sgi-ip27/ip27-klconfig.c
@@ -48,7 +48,7 @@ klinfo_t *find_first_component(lboard_t *brd, unsigned char struct_type)
 	return find_component(brd, (klinfo_t *)NULL, struct_type);
 }
 
-lboard_t * find_lboard(lboard_t *start, unsigned char brd_type)
+lboard_t *find_lboard(lboard_t *start, unsigned char brd_type)
 {
 	/* Search all boards stored on this node. */
 	while (start) {
@@ -60,7 +60,7 @@ lboard_t * find_lboard(lboard_t *start, unsigned char brd_type)
 	return (lboard_t *)NULL;
 }
 
-lboard_t * find_lboard_class(lboard_t *start, unsigned char brd_type)
+lboard_t *find_lboard_class(lboard_t *start, unsigned char brd_type)
 {
 	/* Search all boards stored on this node. */
 	while (start) {
@@ -78,7 +78,7 @@ cnodeid_t get_cpu_cnode(cpuid_t cpu)
 	return CPUID_TO_COMPACT_NODEID(cpu);
 }
 
-klcpu_t * nasid_slice_to_cpuinfo(nasid_t nasid, int slice)
+klcpu_t *nasid_slice_to_cpuinfo(nasid_t nasid, int slice)
 {
 	lboard_t *brd;
 	klcpu_t *acpu;
@@ -97,7 +97,7 @@ klcpu_t * nasid_slice_to_cpuinfo(nasid_t nasid, int slice)
 	return (klcpu_t *)NULL;
 }
 
-klcpu_t * sn_get_cpuinfo(cpuid_t cpu)
+klcpu_t *sn_get_cpuinfo(cpuid_t cpu)
 {
 	nasid_t nasid;
 	int slice;
-- 
1.7.1.251.gf80a2
