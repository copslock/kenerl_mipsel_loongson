Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Aug 2008 14:45:59 +0100 (BST)
Received: from mx1.redhat.com ([66.187.233.31]:5829 "EHLO mx1.redhat.com")
	by ftp.linux-mips.org with ESMTP id S20025890AbYH0Np5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 27 Aug 2008 14:45:57 +0100
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m7RDjtnl005220;
	Wed, 27 Aug 2008 09:45:55 -0400
Received: from pobox.devel.redhat.com (pobox.devel.redhat.com [10.11.255.8])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m7RDjsmJ002106;
	Wed, 27 Aug 2008 09:45:54 -0400
Received: from warthog.cambridge.redhat.com (IDENT:U2FsdGVkX191U4PfgFzyavhbBH9pvVl0XZ5c+rZeX8o@xen4-1.farm.hsv.redhat.com [10.15.4.90])
	by pobox.devel.redhat.com (8.13.1/8.13.1) with ESMTP id m7RDjrE5021398;
	Wed, 27 Aug 2008 09:45:53 -0400
Received: from [127.0.0.1] (helo=warthog.procyon.org.uk)
	by warthog.cambridge.redhat.com with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KYLLM-0005F5-Ji; Wed, 27 Aug 2008 14:45:52 +0100
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From:	David Howells <dhowells@redhat.com>
Subject: [PATCH 02/59] CRED: Wrap task credential accesses in the MIPS arch
To:	linux-kernel@vger.kernel.org
Cc:	linux-security-module@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Serge Hallyn <serue@us.ibm.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Date:	Wed, 27 Aug 2008 14:45:52 +0100
Message-ID: <20080827134552.19980.14045.stgit@warthog.procyon.org.uk>
In-Reply-To: <20080827134541.19980.61042.stgit@warthog.procyon.org.uk>
References: <20080827134541.19980.61042.stgit@warthog.procyon.org.uk>
User-Agent: StGIT/0.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Return-Path: <dhowells@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20376
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhowells@redhat.com
Precedence: bulk
X-list: linux-mips

Wrap access to task credentials so that they can be separated more easily from
the task_struct during the introduction of COW creds.

Change most current->(|e|s|fs)[ug]id to current_(|e|s|fs)[ug]id().

Change some task->e?[ug]id to task_e?[ug]id().  In some places it makes more
sense to use RCU directly rather than a convenient wrapper; these will be
addressed by later patches.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: James Morris <jmorris@namei.org>
Acked-by: Serge Hallyn <serue@us.ibm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/kernel/mips-mt-fpaff.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)


diff --git a/arch/mips/kernel/mips-mt-fpaff.c b/arch/mips/kernel/mips-mt-fpaff.c
index df4d3f2..928c72b 100644
--- a/arch/mips/kernel/mips-mt-fpaff.c
+++ b/arch/mips/kernel/mips-mt-fpaff.c
@@ -51,6 +51,7 @@ asmlinkage long mipsmt_sys_sched_setaffinity(pid_t pid, unsigned int len,
 	int retval;
 	struct task_struct *p;
 	struct thread_info *ti;
+	uid_t euid;
 
 	if (len < sizeof(new_mask))
 		return -EINVAL;
@@ -76,9 +77,9 @@ asmlinkage long mipsmt_sys_sched_setaffinity(pid_t pid, unsigned int len,
 	 */
 	get_task_struct(p);
 
+	euid = current_euid();
 	retval = -EPERM;
-	if ((current->euid != p->euid) && (current->euid != p->uid) &&
-			!capable(CAP_SYS_NICE)) {
+	if (euid != p->euid && euid != p->uid && !capable(CAP_SYS_NICE)) {
 		read_unlock(&tasklist_lock);
 		goto out_unlock;
 	}
