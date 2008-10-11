Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Oct 2008 21:59:21 +0100 (BST)
Received: from ey-out-1920.google.com ([74.125.78.144]:64777 "EHLO
	ey-out-1920.google.com") by ftp.linux-mips.org with ESMTP
	id S21245376AbYJKU7S (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 11 Oct 2008 21:59:18 +0100
Received: by ey-out-1920.google.com with SMTP id 4so542351eyg.54
        for <linux-mips@linux-mips.org>; Sat, 11 Oct 2008 13:59:17 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type;
        bh=bDvEoUxyVgubmLFI/Xy60DxJHYRdIDJccyPTNOKb9z4=;
        b=wKNWWzpwr4vkinwA3FwWHns3kc0rmZqDws9umgT/wzMVEbqTwzEpiYMpJGuasl2FUs
         gBdpPtgtjDgl7y1CTSUnqV5X0mAjYvtpB9497OOcsZu5RR8dMFIDR3LjeLtYeJHW9vRk
         Fc0Jv+KUtm8rfEk4AATFwY44+2KF80tOwgOSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type;
        b=W8+gCA3mFWN1pnlA904leiegwiHDEkfsPdibsuOmZPWmaOr2rHRY1TfJngEXi+jwsT
         5lcFmdH/dojPaDl0YtggEadupWX/rr26DoFSXl7VRlqXVm+A1q5r9muX71hrggvOQm58
         cnyOOnNtSRAkLG8I6QZ+BbKM+kNSMuoNfeX+c=
Received: by 10.210.24.12 with SMTP id 12mr2620062ebx.91.1223758757424;
        Sat, 11 Oct 2008 13:59:17 -0700 (PDT)
Received: by 10.210.56.5 with HTTP; Sat, 11 Oct 2008 13:59:17 -0700 (PDT)
Message-ID: <b2b2f2320810111359v17ab02e2mf7de64169d8a9e9f@mail.gmail.com>
Date:	Sat, 11 Oct 2008 14:59:17 -0600
From:	"Shane McDonald" <mcdonald.shane@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: One file still left in include/asm-mips
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_22668_9839462.1223758757428"
Return-Path: <mcdonald.shane@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcdonald.shane@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_22668_9839462.1223758757428
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I just noticed that in the current HEAD of the linux-mips.org git
repository, all of the files in include/asm-mips have been moved to
arch/mips/include/asm, with the exception of cevt-r4k.h.  It looks so lonely
sitting there all by itself, maybe we should put it with its friends. :-)

Shane McDonald

------=_Part_22668_9839462.1223758757428
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">I just noticed that in the current HEAD of the <a href="http://linux-mips.org">linux-mips.org</a> git repository, all of the files in include/asm-mips have been moved to arch/mips/include/asm, with the exception of cevt-r4k.h.&nbsp; It looks so lonely sitting there all by itself, maybe we should put it with its friends. :-)<br>
<br>Shane McDonald<br></div>

------=_Part_22668_9839462.1223758757428--
