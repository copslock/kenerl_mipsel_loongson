Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Feb 2009 09:29:56 +0000 (GMT)
Received: from mx1.moondrake.net ([212.85.150.166]:23172 "EHLO
	mx1.mandriva.com") by ftp.linux-mips.org with ESMTP
	id S20808006AbZBWJ3x (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Feb 2009 09:29:53 +0000
Received: by mx1.mandriva.com (Postfix, from userid 501)
	id 2C0A4274002; Mon, 23 Feb 2009 10:29:53 +0100 (CET)
Received: from office-abk.mandriva.com (office-abk.mandriva.com [84.55.162.90])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.mandriva.com (Postfix) with ESMTP id A3EA1274003;
	Mon, 23 Feb 2009 10:29:49 +0100 (CET)
Received: from anduin.mandriva.com (fw2.mandriva.com [192.168.2.3])
	by office-abk.mandriva.com (Postfix) with ESMTP id E1E7C82816;
	Mon, 23 Feb 2009 10:30:26 +0100 (CET)
Received: from anduin.mandriva.com (localhost [127.0.0.1])
	by anduin.mandriva.com (Postfix) with ESMTP id 9213BFF855;
	Mon, 23 Feb 2009 10:30:36 +0100 (CET)
From:	Arnaud Patard <apatard@mandriva.com>
To:	wurststulle <wurststulle@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: kexec on mips - anyone has it working?
References: <483BCB75.4050901@wpkg.org>
	<200805271405.55346.nschichan@freebox.fr> <483C0135.9070203@wpkg.org>
	<200805271449.45124.nschichan@freebox.fr> <483C4F73.4040909@wpkg.org>
	<200805291347.05196.nschichan@freebox.fr> <483F0EF3.3060500@wpkg.org>
	<200805301327.11925.nschichan@freebox.fr> <483FE764.1090901@wpkg.org>
	<200807011542.29274.nschichan@freebox.fr> <486A6F0D.4070802@wpkg.org>
	<200807012000.40421.nschichan@freebox.fr> <486A759D.6080803@wpkg.org>
	<22148789.post@talk.nabble.com>
Organization: Mandriva
Date:	Mon, 23 Feb 2009 10:30:36 +0100
In-Reply-To: <22148789.post@talk.nabble.com> (wurststulle@gmail.com's message of "Sun, 22 Feb 2009 08:50:27 -0800 (PST)")
Message-ID: <m3d4d9o5z7.fsf@anduin.mandriva.com>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <arnaud.patard@mandriva.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21956
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apatard@mandriva.com
Precedence: bulk
X-list: linux-mips

wurststulle <wurststulle@gmail.com> writes:

Hi,

> is there any solution for this, i have the same problem

What's your exact problem ? It hangs right after saying 'Bye...' ?
Some monthes ago, I played with the patch from M. Syrchin [ sorry, I don't
remember if it was on linux-mips or on the kexec list ]. I've made on it
a small modification (compare the machine_kexec_prepare function in my
version [1] and the original function) and it was somewhat working on
Qemu and on my box. It was not perfect but at least with a very minimal
test system, it was working. Maybe you can try it and see if it works
for you too. Depending on your platform, you may have to define machine
specific hooks too.

Regards,
Arnaud

[1] http://people.mandriva.com/~apatard/kexec_mips.patch
