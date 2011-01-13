Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jan 2011 11:02:33 +0100 (CET)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:37821 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492572Ab1AMKCa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Jan 2011 11:02:30 +0100
Received: by iwn38 with SMTP id 38so1402828iwn.36
        for <linux-mips@linux-mips.org>; Thu, 13 Jan 2011 02:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=iu+mfZM4FaTgl1u0lI/UyCBoqiwcQfHq7a7wF2nOTn8=;
        b=KaI5Efy2kMJLx9T8mFFjybE7pQmf5BvsNWNWQzEF32LviJXh6fCNcxI6uUwg1XoD8u
         8TeZMyd6jqkYmaIugkpQyig8RCl+BVYAygBi4d2dqtFfS0ng5xweQWGB+cNOeyJRLJLm
         yUDtRaDYp6rLPMbURa1wa9XiCIo2dzxutrByg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=lZM9lvoHOQwPMF8u8C/qAa6aBNjskywSzV3LZegUCDqr18GCWI1iuCmaTZ/fGNoY9f
         ej3Gx/lNzn3q0rGaOJVQJWNSTD8zL5ALj6WbabdWoTmvQ++BosGX6smxkKPd9J5g0xlI
         VOB6vYolU4sWdVTFaUjafS/1TUZorismvCu+g=
MIME-Version: 1.0
Received: by 10.42.176.70 with SMTP id bd6mr1792195icb.164.1294912949014; Thu,
 13 Jan 2011 02:02:29 -0800 (PST)
Received: by 10.42.195.199 with HTTP; Thu, 13 Jan 2011 02:02:28 -0800 (PST)
Date:   Thu, 13 Jan 2011 18:02:28 +0800
Message-ID: <AANLkTinvdEPwQ=DmcF8nnTAa0Py_O=+p7x1pobcTNHom@mail.gmail.com>
Subject: about udelay in mips
From:   loody <miloody@gmail.com>
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <miloody@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28901
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: miloody@gmail.com
Precedence: bulk
X-list: linux-mips

hi all:
If i trace source in the correct place, I found udelay(100) is
implemented as a loop which decrease 1 per iteration until the count,
100, as 0.
What makes me confused is since the speed of cpus are different and
that will make udelay not precise on different platform, right?

-- 
Regards,
miloody
