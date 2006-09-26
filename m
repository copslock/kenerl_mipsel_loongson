Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Sep 2006 08:13:32 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.185]:23845 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20037585AbWIZHN2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 26 Sep 2006 08:13:28 +0100
Received: by nf-out-0910.google.com with SMTP id l23so131977nfc
        for <linux-mips@linux-mips.org>; Tue, 26 Sep 2006 00:13:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding:from;
        b=fVyC9JpJGA9ujyerC0EZA0ov/QrPBMpStWGLH69Gjz2fyVnaKm/dmqnC50JlF7ebIJn+1mzZ4V/1kkpRhcAPstcf8Zd+ggQ1erGu9XEIoKGSosGds/UBmzHpnVUgzbNBkKj1A90I7ly2uo9AxVvAJY2T1YNPfEH/wUf27Vsa4xc=
Received: by 10.48.220.15 with SMTP id s15mr663242nfg;
        Tue, 26 Sep 2006 00:13:25 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.gmail.com with ESMTP id p45sm726906nfa.2006.09.26.00.13.24;
        Tue, 26 Sep 2006 00:13:25 -0700 (PDT)
Message-ID: <4518D33F.9070208@innova-card.com>
Date:	Tue, 26 Sep 2006 09:14:07 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: How to work with Linux-Mips ?
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12667
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

First of all, I'm sending this email because I really want to
understand how linux-mips is working with its community. I'm asking
this question because I'm wondering how many times I should resend a
patch before it can be considered for applying.

For example, I posted some patches more than one month ago. I really
think that these patches improve the MIPS specific code and they are
not complex at all:

http://www.linux-mips.org/archives/linux-mips/2006-08/msg00112.html
http://www.linux-mips.org/archives/linux-mips/2006-08/msg00113.html
http://www.linux-mips.org/archives/linux-mips/2006-08/msg00114.html
http://www.linux-mips.org/archives/linux-mips/2006-08/msg00115.html
http://www.linux-mips.org/archives/linux-mips/2006-08/msg00117.html
http://www.linux-mips.org/archives/linux-mips/2006-08/msg00118.html

http://www.linux-mips.org/archives/linux-mips/2006-08/msg00196.html
http://www.linux-mips.org/archives/linux-mips/2006-08/msg00195.html
http://www.linux-mips.org/archives/linux-mips/2006-08/msg00197.html

These patchs have been kindly reviewed and acked by Atsushi Nemoto,
but then no feedback from the MIPS team. I tried to get a status for
MIPS team a couple of time, to know if something was wrong with them
but MIPS people seem to not care about them. They even haven't
bothered to take 10 seconds for replying something like:

  - your patches are broken because...

  - your patches do not respect our MIPS protocol, please resend...

  - Sorry we are very busy, please hold on...

  - OK your patches suck please try to work on ARM chips because MIPS
    is a very closed circle reserved to MIPS gurus.

Another question, is that MIPS tree seems to not care about linux
mainline release process. I actually notice that even Linus do not
pull MIPS tree anymore during the last release candidate cycle. Is
MIPS aware that some of its customers are trying to make stable
releases ? Does the linux-mips team exist to ease life of its
customers to use the linux kernel on MIPS chips or is the purpose of
this team doing only some development for fun ?

Hoping this time I'll get some answers.

		Franck
