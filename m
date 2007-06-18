Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jun 2007 08:36:20 +0100 (BST)
Received: from an-out-0708.google.com ([209.85.132.249]:47364 "EHLO
	an-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20023191AbXFRHgR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 18 Jun 2007 08:36:17 +0100
Received: by an-out-0708.google.com with SMTP id d26so331811and
        for <linux-mips@linux-mips.org>; Mon, 18 Jun 2007 00:36:06 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        b=DG2A9I/NM1RsnnmZhQrk3Fs9ek+gdPHkJmhPD6MXGgIE9fHUtfkYFXRXSAZOxucC8BVFc1s02yxJiHQlC/l6yIHi/Cv9t2J2JgKfVjAbOVT+0UPAocxd2RdPRH9g2ndGHT8X0UL7DVCPryGvJGwqJzwfwwl+OpRNl7yTYv9pIuw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=L5xoKeSKOuw7d6tbtxFOEjzaSBGNMNzbvh1mYLwEmZBcVQv+xEVo1gmtpB1SJiBoXX2BnToGmznheDl/fX+u/N/PgAafoKzyUcOgOZ4mXnXLOT+J/RRQV0M666NTnPzX5z/+bMCaqmJXXYoLQ749M+pYYIJkuWOQ3fvlXlIPVDU=
Received: by 10.100.8.18 with SMTP id 18mr3299082anh.1182152166316;
        Mon, 18 Jun 2007 00:36:06 -0700 (PDT)
Received: by 10.100.33.16 with HTTP; Mon, 18 Jun 2007 00:36:06 -0700 (PDT)
Message-ID: <e6480a290706180036m23996de9re866607186f404cf@mail.gmail.com>
Date:	Mon, 18 Jun 2007 15:36:06 +0800
From:	"mao ye" <ym.uestc@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: About binutils for mips
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_125259_28715221.1182152166296"
Return-Path: <ym.uestc@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ym.uestc@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_125259_28715221.1182152166296
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I compile the rtems ,but I meet some trouble:
opcode not supported on this processor: mips1(mips1)'dmfc0 $8,$14'
 opcode not supported on this processor: mips1(mips1)'dadd $5,$4,$0'
 opcode not supported on this processor: mips1(mips1)'dsll $9,$9,2'
 opcode not supported on this processor: mips1(mips1)'eret'

The version of gcc is gcc-3.4.3,and the version of binutils is 2.15.

Does the binutils-2.15 not support the mips1 or some other reasons?

Thanks.
                    ye mao

------=_Part_125259_28715221.1182152166296
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>I compile the rtems ,but I meet some trouble:</div>
<div>opcode not supported on this processor: mips1(mips1)&#39;dmfc0 $8,$14&#39;</div>
<div>
<div>opcode not supported on this processor: mips1(mips1)&#39;dadd $5,$4,$0&#39;</div>
<div>
<div>opcode not supported on this processor: mips1(mips1)&#39;dsll $9,$9,2&#39;</div>
<div>
<div>opcode not supported on this processor: mips1(mips1)&#39;eret&#39;</div>
<div>&nbsp;</div>
<div>The version of gcc is gcc-3.4.3,and the version of binutils is 2.15.</div>
<div>&nbsp;</div>
<div>Does&nbsp;the binutils-2.15 not support the mips1 or some other&nbsp;reasons?</div>
<div>&nbsp;</div>
<div>Thanks.</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ye mao&nbsp;</div></div></div></div>

------=_Part_125259_28715221.1182152166296--
