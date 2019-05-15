Return-Path: <SRS0=sPT9=TP=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77531C04E53
	for <linux-mips@archiver.kernel.org>; Wed, 15 May 2019 15:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5070321473
	for <linux-mips@archiver.kernel.org>; Wed, 15 May 2019 15:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbfEOPfY (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 15 May 2019 11:35:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60786 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbfEOPfY (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Wed, 15 May 2019 11:35:24 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8E07930842A2;
        Wed, 15 May 2019 15:35:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id 884EC60BE5;
        Wed, 15 May 2019 15:35:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 15 May 2019 17:35:20 +0200 (CEST)
Date:   Wed, 15 May 2019 17:35:15 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     jannh@google.com, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, dhowells@redhat.com, akpm@linux-foundation.org,
        cyphar@cyphar.com, ebiederm@xmission.com,
        elena.reshetova@intel.com, keescook@chromium.org,
        luto@amacapital.net, luto@kernel.org, tglx@linutronix.de,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] pid: add pidfd_open()
Message-ID: <20190515153515.GA20783@redhat.com>
References: <20190515100400.3450-1-christian@brauner.io>
 <20190515143857.GB18892@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515143857.GB18892@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 15 May 2019 15:35:24 +0000 (UTC)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On 05/15, Oleg Nesterov wrote:
>
> On 05/15, Christian Brauner wrote:
> >
> > +SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
> > +{
> > +	int fd, ret;
> > +	struct pid *p;
> > +	struct task_struct *tsk;
> > +
> > +	if (flags)
> > +		return -EINVAL;
> > +
> > +	if (pid <= 0)
> > +		return -EINVAL;
> > +
> > +	p = find_get_pid(pid);
> > +	if (!p)
> > +		return -ESRCH;
> > +
> > +	rcu_read_lock();
> > +	tsk = pid_task(p, PIDTYPE_PID);
>
> You do not need find_get_pid() before rcu_lock and put_pid() at the end.
> You can just do find_vpid() under rcu_read_lock().

Ah, sorry. Somehow I forgot you need to call pidfd_create(pid), you can't
do this under rcu_read_lock().

So I was wrong, you can't avoid get/put_pid.

Oleg.

