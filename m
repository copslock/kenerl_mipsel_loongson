Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Aug 2007 16:22:30 +0100 (BST)
Received: from an-out-0708.google.com ([209.85.132.251]:19595 "EHLO
	an-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20027480AbXH0PWV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 27 Aug 2007 16:22:21 +0100
Received: by an-out-0708.google.com with SMTP id d26so194848and
        for <linux-mips@linux-mips.org>; Mon, 27 Aug 2007 08:22:03 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=CfyuJXdpDA58l6sUpH6iQ2oPxhiuKXWD2U/zkQ1pI1CkzszItkuAqKrj+LOL9eT3n5ksfZAmbKK5q0yIfJ/isUnFjcVx6jcOx+o6GFDuZYv4J1yeCSwT6uCRv9l1d9L+Wh70x1MPnV3wHjIYZzG7nBKNWw7BB9f7HAKCOoArfvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DmZ0+JUn7TBv2DeXIdqCBhjncwD8EC/jzia5C3VDFiaOJohJw07cW37v1oc1Bj0/vXmZGcmQag7hRNbn7vdpH4q8FvcxGc0umrTPqveb8NdIQQoFAxAtFpiWlvgguF2UqbFkvUfW2BPJ2DOwMK6EXQFVCIgYDQ2lOZ/7nPUtdE8=
Received: by 10.100.37.4 with SMTP id k4mr1739199ank.1188228122919;
        Mon, 27 Aug 2007 08:22:02 -0700 (PDT)
Received: by 10.100.94.4 with HTTP; Mon, 27 Aug 2007 08:22:02 -0700 (PDT)
Message-ID: <99ac6e0e0708270822w32f8a024gd18c5883c86c8713@mail.gmail.com>
Date:	Mon, 27 Aug 2007 10:22:02 -0500
From:	"bo y" <byu1000@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: tlbex.c
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <byu1000@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16296
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: byu1000@gmail.com
Precedence: bulk
X-list: linux-mips

Should the following instruction field masks to be 0x3f ?

   #define OP_MASK         0x2f
   #define FUNC_MASK       0x2f

I do not see OP_MASK is used but FUNC_MASK is used in the same file.


Bo
