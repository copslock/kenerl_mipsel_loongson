Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jan 2016 15:43:25 +0100 (CET)
Received: from mail-wm0-f50.google.com ([74.125.82.50]:34208 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009535AbcAVOnXchMgd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jan 2016 15:43:23 +0100
Received: by mail-wm0-f50.google.com with SMTP id u188so21420093wmu.1;
        Fri, 22 Jan 2016 06:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=CLqDWhmTu+h8bcf/2RJsY0U0I94k8nmSsFTTs4s1Pt0=;
        b=cw2y00GQqZHlwyINnNbfMz7jjE7FZ6p4ils4u6wDFaXYxdn6o4cmLg387N9sIYicmU
         tIzHS0E3TT7FH71SLyJhlJGDRvZ3q4qEdUnTdLGuo7veVy6rOECiQ2Tg3RbitKNiKdAG
         oj/Vmo4WjR3tzCToyjilKhxIBLr1LbKp3I+dCS3ivpZ/949ieGXhOta9meQShBVD3r4y
         1zc+j5P8dWJ+ALv7UNFD96RVaIQ2aOBcBQNR6/dgFnCC0fbj/6ygTNrxStpun0xJyYN6
         lvT6mNKkxUSVs82FkaFhIXNHxI+PIitep5BU2zaMC2WZuOhQ35lp/R+z4MlY9NzEcla1
         ihVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=CLqDWhmTu+h8bcf/2RJsY0U0I94k8nmSsFTTs4s1Pt0=;
        b=fCITxwmOR98DHmRDNc4DKk8s9O0qCFtUIFeKH0ngxm43jzsAv50lX3scgh1Y18PyEv
         PBtuCvXoKEBU4H9DHd3OqMEJP953o/X38k6yytKtnpXx7tnZGe3a2pTfDcPCacc0h44Z
         PPmpSeQmfNAoFHjruqIJt3LLKnQvqELdUfi7zVgwPdKT/ycTiAZtsVBdzWdt25SD56ny
         4GEjzXuarxmbg6JgYSCj3q8CKgbq4K+F+XxltEni9gaAAzZ2BJpGx9a11lfM7k488TWr
         7Cy0WspysTSZMutNYgdakXhPdF74X9fXq59DPngO3Brqp3uEfQkmXK++RJsFWyurSceh
         g69Q==
X-Gm-Message-State: AG10YOSGlKWn8A7tgfHT9PSd5hd4o+Mz4qpjVgnsYqHqn25RfqrHXTozGPoXbFuCOQR5Q996L4yhLUkJI1i5ZQ==
X-Received: by 10.28.214.76 with SMTP id n73mr4294792wmg.52.1453473798242;
 Fri, 22 Jan 2016 06:43:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.136.68 with HTTP; Fri, 22 Jan 2016 06:42:38 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Fri, 22 Jan 2016 15:42:38 +0100
Message-ID: <CAOLZvyFLqs5cwpxFg=NSepwBESsb2T-_3y864yb2mvXbctChiQ@mail.gmail.com>
Subject: MIPS: Please revert "MIPS: Fix PAGE_MASK definition"
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51309
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hello,

Commit 22b14523994588279ae9c5ccfe64073c1e5b3c00 ("MIPS: Fix PAGE_MASK
definition")
breaks the extended 36bit IO space on Alchemy (i.e. PCI and PCMCIA don't work).
A simple revert fixes it. (Additionally, I've actually never seen the
warning it is supposed to fix
in my 32 bit builds).

Thanks!
     Manuel Lauss
