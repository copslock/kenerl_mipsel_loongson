Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Nov 2009 16:22:57 +0100 (CET)
Received: from mail-gx0-f210.google.com ([209.85.217.210]:43344 "EHLO
	mail-gx0-f210.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493396AbZKPPWu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Nov 2009 16:22:50 +0100
Received: by gxk2 with SMTP id 2so5007467gxk.4
        for <linux-mips@linux-mips.org>; Mon, 16 Nov 2009 07:22:44 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=q/HKiHB723pCl9X4ABDpDCSyQVV36e7MTiyM1FYj10k=;
        b=XgaVZKLP6Jpqxs8UGyDB+RF7zW9wBbKfZ1SUCNVB7eZq+k9n8ro6pHuSA7/T3shSQv
         2+nVpnF8m6TqcId0Fok22dC+6VurfWvKo1nG8mhxit8RD+U9+3u/XOok7bjCWyOekM1+
         ZMX1w6fqilIYyIi8q/DP2qnLlbKMjQd+y3+tE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=bwXlnTIcCetLHW50a2uNJQtTa/6VYb4jo8I2t0uqFLaKZd2jwu6vaDfb1/2ITjwkYF
         H06UYnD0xzfSaLTQfwZ3+35nuJDUXqCZJtVmon2Ewj4Cwt2WvXAHEFsIElBcuOOnCp/B
         Di+wxTpukgRFtH1jNGSMYwSgTjruyyhUvL4M0=
MIME-Version: 1.0
Received: by 10.91.19.15 with SMTP id w15mr7336366agi.12.1258384960344; Mon, 
	16 Nov 2009 07:22:40 -0800 (PST)
Date:	Mon, 16 Nov 2009 23:22:40 +0800
Message-ID: <e997b7420911160722g300c89bbx9adb6004049b4da4@mail.gmail.com>
Subject: about kexec support on mips smp
From:	"wilbur.chan" <wilbur512@gmail.com>
To:	Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wilbur512@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilbur512@gmail.com
Precedence: bulk
X-list: linux-mips

Hi all!

Recently , I am trying    kexec smp feature support for ppc64,  and mips64 .

I found that , ppc64  makes  the secondary cpus to spin in a loop
,while in mips64 , the seconday cpus wait until the main cpu  jumped
to kernel entry , and then they(secondary cpus)

jumped to kernel entry too .



So I 've got some questions on the entry point for cpus.

It seemed that , in kernel code , seconday cpus were brought up by
main cpu in a 'init' process .

After initializing , the main cpu send ipi to all  secondary cpus
,waked them up , and  then , secondary cpus jump to a different
'secondary ' entry point. But patches show that ,all cpus

will jumped to the same entry ,so I 'm not sure about this , if all
cpus would have the simillar  boot process  or not.



Any suggestion?

Thank you


regards,

wilbur
