Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Feb 2013 14:23:30 +0100 (CET)
Received: from mail-ie0-f181.google.com ([209.85.223.181]:38149 "EHLO
        mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826533Ab3BINXaIrkvu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 9 Feb 2013 14:23:30 +0100
Received: by mail-ie0-f181.google.com with SMTP id 17so6058902iea.26
        for <linux-mips@linux-mips.org>; Sat, 09 Feb 2013 05:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=CX4qdacUOc/rXRhAKOCa+4p7eRGfwYh4Z5L+jaDFp80=;
        b=UnGUvwRwEGY+oEJIkJvnCfZtLWgNt73aOBlBKRySeAP+Oyk6FjQlkolpR0MU+T+O2s
         Fg2IcTskrdp85Sovx2NYXbCTWiH/Ha2Wad/R8DsIRdAoic76QBXARhTnaATlqD65W6xI
         m+whf9J7hA65bBe6W8DRM7fHSJRbzODJkh0+qbCZ02BFPYe+t7BNkud/z1hP8FNKk+hR
         kXXVEG0CvFlLeUFwA/e118eODzkytB+BpJX/qoYJr5shYLovzblYAT2AgyLvnIAus2Ol
         iXBBDoO6zJOWwq0DDhjNqi+Cj2TtbKkFm+PnGnPbB6FTLZuT/7mt/h6Ljo8Wk1LKQlD7
         o87w==
X-Received: by 10.50.88.200 with SMTP id bi8mr7599596igb.52.1360416203403;
 Sat, 09 Feb 2013 05:23:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.42.85.83 with HTTP; Sat, 9 Feb 2013 05:23:03 -0800 (PST)
From:   Ronny Meeus <ronny.meeus@gmail.com>
Date:   Sat, 9 Feb 2013 14:23:03 +0100
Message-ID: <CAMJ=MEdryShKJD9v5Xp3ZouPzss_TK+QjVZ=Nng3cvDGfAiYzA@mail.gmail.com>
Subject: Reserving a part of the system ram.
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 35730
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ronny.meeus@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello

I have a board that has 4Gb of RAM which can completely be used by
Linux, except for a 64Mb block located just below the 2G boundary.
This block will be used to implement a kind of persistent storage.

On PPC we do this with a memreserve in the device tree but this does
not seem to work on MIPS.
Another option I found is the memmap kernel parameter, which  can also
be used the reserve a piece of memory that is reserved (something like
memmap=size$addres would do the trick, but no luck, this is also not
supported.

This is the Linux version I'm using for my project:
Linux version 2.6.32.27-Cavium-Octeon

What is the correct way to make this work?

Thanks,
Ronny
