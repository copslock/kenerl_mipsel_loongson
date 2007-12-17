Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Dec 2007 13:18:11 +0000 (GMT)
Received: from nz-out-0506.google.com ([64.233.162.238]:54919 "EHLO
	nz-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20026800AbXLQNSD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 17 Dec 2007 13:18:03 +0000
Received: by nz-out-0506.google.com with SMTP id n1so805480nzf.24
        for <linux-mips@linux-mips.org>; Mon, 17 Dec 2007 05:17:49 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=YeW/VmpMHXbDLWNTjGYJidpIolxjDKcJRZJhK0L8yXM=;
        b=Vacn1WW2qjErAje1O0a3J/U2hnZm5juGde/bhMEk6Zb/ma040Rj1xsuceSC3QYlXBz8iDxEplIfcOOxHCp5VNj9Ci3CGPkU+2EZI9UIfjffgoZLkf1wP12qhjeXxCwAVhxNLym9WKKX9/kENXN54alYsSRsNAX3Zsw7eDyDklYE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=BmJ2VV/2fF3MiglboTJRlhH3D4w+27tROQX8goCCPQ/56FPVMt3Ocpcg/Ke9soL9NU8ZrwDOzUVuNlv7g9rkZ4XbK/C8TYSHaAB/7R+O3uFTvHn8OKHIzy7gtaXzUBOS6sVdO8M6gJxg5eONEJ0jx+5LGZx/rzerZVLu30UkYoI=
Received: by 10.142.229.4 with SMTP id b4mr509758wfh.118.1197897468747;
        Mon, 17 Dec 2007 05:17:48 -0800 (PST)
Received: by 10.142.214.9 with HTTP; Mon, 17 Dec 2007 05:17:48 -0800 (PST)
Message-ID: <73cd086a0712170517i146a452exea775f3942c1d5da@mail.gmail.com>
Date:	Mon, 17 Dec 2007 16:17:48 +0300
From:	"Pavel Kiryukhin" <vksavl@gmail.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH][MIPS] fix user_cpus_allowed assignment
Cc:	vksavl@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <vksavl@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17830
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vksavl@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,
there seems to be a bug in affinity handling for CONFIG_MIPS_MT_FPAFF=y.
It can be easily reproduced - for two-cpus system set new mask to 4.
Call fails, but next sched_getaffinity() call returns 0 as current
mask.
Simple fix is below.

Signed-off-by: Pavel Kiryukhin <vksavl@gmail.com>

diff --git a/arch/mips/kernel/mips-mt-fpaff.c
b/arch/mips/kernel/mips-mt-fpaff.cindex 892665b..774f91e 100644
--- a/arch/mips/kernel/mips-mt-fpaff.c
+++ b/arch/mips/kernel/mips-mt-fpaff.c
@@ -87,9 +87,6 @@ asmlinkage long mipsmt_sys_sched_setaffinity(pid_t
pid, unsigned int len,
        if (retval)
                goto out_unlock;

-       /* Record new user-specified CPU set for future reference */
-       p->thread.user_cpus_allowed = new_mask;
-
        /* Unlock the task list */
        read_unlock(&tasklist_lock);

@@ -104,6 +101,10 @@ asmlinkage long
mipsmt_sys_sched_setaffinity(pid_t pid, unsigned int len,
                retval = set_cpus_allowed(p, new_mask);
        }

+        /* Record new user-specified CPU set for future reference */
+       if (!retval)
+               p->thread.user_cpus_allowed = new_mask;
+
 out_unlock:
        put_task_struct(p);
        unlock_cpu_hotplug();
