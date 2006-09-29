Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Sep 2006 16:31:03 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.180]:53442 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20039250AbWI2PbC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 29 Sep 2006 16:31:02 +0100
Received: by py-out-1112.google.com with SMTP id i49so25323pyi
        for <linux-mips@linux-mips.org>; Fri, 29 Sep 2006 08:31:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer;
        b=YBNBndilC0Nf28WzLyQXqYvglvxhrPedvU2rJ5uo8OpVJpGI1BX/2tQ+YbFpSNTvNtX892DhSfYSmP/B+7RRhC8fqShsFS0+yPgm0b8AysV5bpHqCcUeFNQTihi7soiSDj5MQHueY+D0kif/aSRssZTIDydVs2GCLA+NrQXP4OM=
Received: by 10.35.107.20 with SMTP id j20mr878954pym;
        Fri, 29 Sep 2006 08:31:00 -0700 (PDT)
Received: from ?192.168.1.3? ( [61.125.212.22])
        by mx.gmail.com with ESMTP id b43sm3621558pyb.2006.09.29.08.30.58;
        Fri, 29 Sep 2006 08:30:59 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v749)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <091C938C-EB20-40AB-A7F1-396FC7C75C47@gmail.com>
Cc:	girishvg@gmail.com
Content-Transfer-Encoding: 7bit
From:	girish <girishvg@gmail.com>
Subject: [PATCH] include children count, in Threads: field present in /proc/<pid>/status (take-1)
Date:	Sat, 30 Sep 2006 00:30:55 +0900
To:	linux-mips@linux-mips.org
X-Mailer: Apple Mail (2.749)
Return-Path: <girishvg@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: girishvg@gmail.com
Precedence: bulk
X-list: linux-mips


Signed-off-by: Girish V. Gulawani <girishvg@gmail.com>

--- linux-vanilla/fs/proc/array.c	2006-09-20 12:42:06.000000000 +0900
+++ linux/fs/proc/array.c	2006-09-30 00:16:59.000000000 +0900
@@ -248,6 +248,8 @@ static inline char * task_sig(struct tas
  	int num_threads = 0;
  	unsigned long qsize = 0;
  	unsigned long qlim = 0;
+	int num_children = 0;
+	struct list_head *_p;

  	sigemptyset(&pending);
  	sigemptyset(&shpending);
@@ -268,9 +270,11 @@ static inline char * task_sig(struct tas
  		qlim = p->signal->rlim[RLIMIT_SIGPENDING].rlim_cur;
  		spin_unlock_irq(&p->sighand->siglock);
  	}
+	list_for_each(_p, &p->children)
+		++num_children;
  	read_unlock(&tasklist_lock);

-	buffer += sprintf(buffer, "Threads:\t%d\n", num_threads);
+	buffer += sprintf(buffer, "Threads:\t%d\n", num_threads +  
num_children);
  	buffer += sprintf(buffer, "SigQ:\t%lu/%lu\n", qsize, qlim);

  	/* render them all */
