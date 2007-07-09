Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jul 2007 04:35:45 +0100 (BST)
Received: from wa-out-1112.google.com ([209.85.146.182]:48864 "EHLO
	wa-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20021433AbXGIDfn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jul 2007 04:35:43 +0100
Received: by wa-out-1112.google.com with SMTP id m16so1088344waf
        for <linux-mips@linux-mips.org>; Sun, 08 Jul 2007 20:35:31 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        b=lSXls2ym9N0C1hRdl3dUs59UbtUQnIdc8cMsekzekTcX0BGaaBuG8FvfUTnsFNY8nR21l/6yhjXxEEIyDQYgqYAM7qjP1kvLZXWzYz2+oqjsHDWk8y6Gy1+TmhyuIv621cVi9wbTKCeuUVXPn8TLHFfvep8fXqQyT62NIgGZT68=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=bWwc8y7zSJknmAxmt95c5+ufCLjDBHplic0z5J7GKf97TsSD9qnHhJGI0eMR4AR9gjWJsIbFN3jpIo6prvODmME2fkElitWPqqECbu1vSTixKJ167hNA+xe0EatUxJeNfaejwIN787OKVVAECcjmSl5OLd1eTeZSprG9bZsykcc=
Received: by 10.114.81.1 with SMTP id e1mr2705762wab.1183952128332;
        Sun, 08 Jul 2007 20:35:28 -0700 (PDT)
Received: by 10.114.166.16 with HTTP; Sun, 8 Jul 2007 20:35:28 -0700 (PDT)
Message-ID: <50c9a2250707082035k5feda677qaceb2771ce666343@mail.gmail.com>
Date:	Mon, 9 Jul 2007 11:35:28 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: remove card cause process in D state( uninterrupted sleep)
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_80045_11756633.1183952128311"
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15651
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_80045_11756633.1183952128311
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hello, all
i use the kernel version: 2.6.14.
while a process playing video in mmc/sd card, suddenly removal of card will
make the process in D(unterrupted sleep) state.
and i also try usb disk suddlen removal,  it's same as card.
does anyone have this situation?
thanks for any hints

best regards



zzh

------=_Part_80045_11756633.1183952128311
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hello, all<br>
i use the kernel version: 2.6.14. <br>
while a process playing video in mmc/sd card, suddenly removal of card will make the process in D(unterrupted sleep) state.<br>
and i also try usb disk suddlen removal,&nbsp; it&#39;s same as card.<br>
does anyone have this situation? <br>
thanks for any hints<br>
<br>
best regards<br>
<br>
<br>
<br>
zzh<br>
<br>

------=_Part_80045_11756633.1183952128311--
