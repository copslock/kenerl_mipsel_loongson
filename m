Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jan 2006 17:27:07 +0000 (GMT)
Received: from amdext3.amd.com ([139.95.251.6]:30116 "EHLO amdext3.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133466AbWAJR0k (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 10 Jan 2006 17:26:40 +0000
Received: from SSVLGW01.amd.com (ssvlgw01.amd.com [139.95.250.169])
	by amdext3.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k0AHTUVM029893;
	Tue, 10 Jan 2006 09:29:30 -0800
Received: from 139.95.250.1 by SSVLGW02.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Tue, 10 Jan 2006 09:29:22 -0800
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
Received: from ldcmail.amd.com (ldcmail.amd.com [147.5.200.40]) by
 amdint.amd.com (8.12.8/8.12.8/AMD) with ESMTP id k0AHTMVP023896; Tue,
 10 Jan 2006 09:29:22 -0800 (PST)
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id BC6F82028; Tue, 10 Jan 2006
 10:29:21 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id k0AHcDlC029945; Tue, 10 Jan 2006 10:38:13
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id k0AHcDYp029944; Tue, 10 Jan 2006 10:38:13
 -0700
Date:	Tue, 10 Jan 2006 10:38:13 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	"Ivan Korzakow" <ivan.korzakow@gmail.com>
cc:	"P. Christeas" <p_christ@hol.gr>, linux-mips@linux-mips.org
Subject: Re: why the early_initcall(au1x00_setup) do not work?
Message-ID: <20060110173813.GA25480@cosmic.amd.com>
References: <50c9a2250601082159p238cacd6r930709da9305479e@mail.gmail.com>
 <20060110141924.GA13779@linux-mips.org>
 <a59861030601100740r432904d9o@mail.gmail.com>
 <200601101757.45297.p_christ@hol.gr>
 <a59861030601100838oa89ac84n@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <a59861030601100838oa89ac84n@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6FDD31782C43938785-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9849
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

> Have you ever tried what you're talking about or is it a guess ?

I just did that.  I have Linus's tree and tags, and Ralf's tree:

git checkout mips
git diff v2.6.14..HEAD

the nice thing about git is that it was written to do exactly the sort 
of things we need it to do, like this.

> For example, let's say that there's a bug introduced when merging
> Linus tree with mips branch. How do you easily "bisect" in order to do
> a binary seek of this bug ?

Linus wrote a HOWTO on that very subject:

http://www.kernel.org/pub/software/scm/git/docs/howto/isolate-bugs-with-bisect.txt

> 2 - The way branches are made is broken : you can not fetch separate
> branches without doing some "grafts" things

I'm no git expert, but can't you just

git-pull rsync://ftp.linux-mips.org/git/linux.git remote:local

That works for me.

Regards,
Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>
