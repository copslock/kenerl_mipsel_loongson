Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2011 22:16:46 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:64715 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491823Ab1DGUQn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Apr 2011 22:16:43 +0200
Received: by wwb17 with SMTP id 17so3062317wwb.24
        for <linux-mips@linux-mips.org>; Thu, 07 Apr 2011 13:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=J+8r3+6c+Pq6MfsiPbQsRq5M+Ydd+CmjtUaCgPhe2g8=;
        b=wrl4ANUO3SeabqGrG4oaDcwcV3saGaKmqAlJGM+9MPFsdmVdnf9EiVVNk1K/yomsPX
         ktykPEQGYpP+iSVFR0kHyEeHb6pHZELhPHXzHfExE14zRZAQIPWyQ1fSaVBRHe9Onh7O
         IlMbBorhL3mnpCDy9CrVkS2FLKEgBE95kiidc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=JxPxZeNZHqeCGnB+NuCHWRdmjM6ItUZ65RMz9iunraY1YBzBiwSbi32IYVWsdgRvS7
         EE3Yhdyit/laahLYOfHj/ACAYrq+8SI00+syA2eVYItY7Rs4Da7WLz8EFAljDSjOF1/z
         zyhygWms1t/srK7gi1gxAVoKLbzO1M2gb/P9k=
MIME-Version: 1.0
Received: by 10.227.139.14 with SMTP id c14mr1365149wbu.55.1302207397323; Thu,
 07 Apr 2011 13:16:37 -0700 (PDT)
Received: by 10.227.145.146 with HTTP; Thu, 7 Apr 2011 13:16:37 -0700 (PDT)
Date:   Thu, 7 Apr 2011 15:16:37 -0500
Message-ID: <BANLkTinakgwx+mihE8OsGH3fUsuf4p4-gw@mail.gmail.com>
Subject: Linux on MIPS emulator?
From:   James Bowery <jabowery@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <jabowery@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29711
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jabowery@gmail.com
Precedence: bulk
X-list: linux-mips

I'd like to run Linux on a MIPS emulator.

Presuming this has been done, is there a "how to" page for this?
