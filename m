Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Oct 2016 07:15:09 +0200 (CEST)
Received: from mail-ua0-f175.google.com ([209.85.217.175]:35168 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992544AbcJHFPDE9nzw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Oct 2016 07:15:03 +0200
Received: by mail-ua0-f175.google.com with SMTP id u68so59533142uau.2
        for <linux-mips@linux-mips.org>; Fri, 07 Oct 2016 22:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=QD0HbhLt4RyR7wCsSDkvgftB94KC0wdHXk4hJ2OGsFA=;
        b=V2wOD9OEmuquoL2xn1XDqjZZe6rTYNnZJ/hcW083w6vLOnBJFcJufiYR0pRKLPOFQc
         6au9y+3/xRcTecWanIGXWfyuIvR1mRaZyMIZDgH97hs19YLLByqEsGsfnUy7YBuHtttU
         bCLKy4p5lm1p22Gyv7izQWrliVQsQChUJbCQ0nKAjIK94hYXIiFUuDfn1S75oOkoCfe2
         mbvRleie6aIIpEGhcxtGskm4IzsmrwHVa+6Dnh249XnxT+HJ7O5vKjQqDAhdZ1l+yXLz
         1NliH7y8+LJOio+Tm0fgRO0ZK8rnZWKGwOuy/eMLJXklkEDhq6DB/JSvU+EIVJJvR8V/
         x5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=QD0HbhLt4RyR7wCsSDkvgftB94KC0wdHXk4hJ2OGsFA=;
        b=Tn7Ji0wpj6yMcSGuLSNi1KUXNcYCq7vpBC+7SDr5Ru+xyAYmSXicaxF7bpMk+ROCpm
         +YLVDRby4zR+Bl9M7o62C2dVg5MLdmSqMJ0ZwTOVjWEp+4WwNXFdFig1WqOQgUk3u9Vd
         0GQxVxobExOa0dfrNscPLgOHfMuNfC7q9rFzXRIOyGSH8qxA17mcPoqaRiQQElDWF2zV
         Y2Zn6hwBunHa7bKSWmARdFQf13Sdf3pmUjPec8vqblofUqNff7xlpa1HSFndo06xry/j
         mj4nR6QshhlesY5uzlCVtMxH8uVRiFDEhW4gqGlPyZAWuJw5FbAglkDcg/S96fVE2C10
         0RrQ==
X-Gm-Message-State: AA6/9RkYOXjQis/RCnPIVZY85yAoa9Hjlkrj5BVH/ZYQnQLBI502o1hd1Qhz/gPo0JNYyABFPEIzgO7pICZQ5A==
X-Received: by 10.159.38.41 with SMTP id 38mr17087482uag.66.1475903697040;
 Fri, 07 Oct 2016 22:14:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.67.80 with HTTP; Fri, 7 Oct 2016 22:14:36 -0700 (PDT)
From:   Sagar Borikar <sagar.borikar@gmail.com>
Date:   Fri, 7 Oct 2016 22:14:36 -0700
Message-ID: <CAFwMWxubq6=eM4Ut8wu8tu+LXLPJsOvoEMC8ASd4SFjsqxE48Q@mail.gmail.com>
Subject: kexec-tools for little endian MIPS
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <sagar.borikar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55373
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sagar.borikar@gmail.com
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

Hi,

I am porting kexec kdump on interaptiv CPU which is running in little
endian mode.
While setting up kexec, I see that the definitions of crash elf
headers are only for big endian.
Is there a support for little endian MIPS in kexec tools?

Thanks
Sagar
