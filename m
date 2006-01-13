Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Jan 2006 18:26:12 +0000 (GMT)
Received: from p549F60EF.dip.t-dialin.net ([84.159.96.239]:64138 "EHLO
	p549F60EF.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S8133356AbWAOSZn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 15 Jan 2006 18:25:43 +0000
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.196]:12779 "EHLO
	wproxy.gmail.com") by linux-mips.net with ESMTP id <S872952AbWAMJWt> convert rfc822-to-8bit;
	Fri, 13 Jan 2006 10:22:49 +0100
Received: by wproxy.gmail.com with SMTP id 71so622125wri
        for <linux-mips@linux-mips.org>; Fri, 13 Jan 2006 01:20:47 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=L20i5tpr3BBMdQM426soZQW+OAVgr+gOphYpnfUfoXFyinXQwJ8+eLkWVktNV77M7TR5BqHVAPSjWL190pHOeuKoyPmCVBCppDBtl4fJEV4OknxRZ8CY8xCpReiWRH0cBEJ74wi0mcUC5nL5Px2bboDbZjvTHMCJK2VqY86Z16g=
Received: by 10.54.145.12 with SMTP id s12mr3761256wrd;
        Fri, 13 Jan 2006 01:20:47 -0800 (PST)
Received: by 10.54.69.11 with HTTP; Fri, 13 Jan 2006 01:20:47 -0800 (PST)
Message-ID: <a59861030601130120y3456b6dat@mail.gmail.com>
Date:	Fri, 13 Jan 2006 10:20:47 +0100
From:	Ivan Korzakow <ivan.korzakow@gmail.com>
To:	linux-mips@linux-mips.org
Subject: How to apply 2.6.15-git7 patchset ?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Return-Path: <ivan.korzakow@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ivan.korzakow@gmail.com
Precedence: bulk
X-list: linux-mips

Hi

Could anybody tell me why I can't apply cleanly the
"patch-2.6.15-git7.bz2" patchset on a mips repository ? Of course I
tried to apply this patch on a 2.6.15 tree...
Actually only mips files failed to be patched.

Ivan
