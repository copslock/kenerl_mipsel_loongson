Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 May 2017 22:27:36 +0200 (CEST)
Received: from mout.web.de ([212.227.15.4]:57946 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994786AbdEXU13QO00Q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 May 2017 22:27:29 +0200
Received: from [192.168.1.2] ([92.228.187.15]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LpfFO-1dqYBk0wB4-00fU3m; Wed, 24
 May 2017 22:26:46 +0200
Subject: Re: MIPS: Alchemy: Delete an error message for a failed memory
 allocation in alchemy_pci_probe()
To:     Randy Dunlap <rdunlap@infradead.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        linux-mips@linux-mips.org
Cc:     Paul Burton <paul.burton@imgtec.com>,
        =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <6ebb5193-239f-5c34-c5f6-2be8a2fa79a5@users.sourceforge.net>
 <CAOLZvyHq-7q0XxiBsyX3q0g0J3kjfFv4SU7amX1hpjRDyK+feQ@mail.gmail.com>
 <796029e7-60a3-a94b-8b5c-4686a0656560@users.sourceforge.net>
 <98579b27-3052-0300-ec67-84f75f761a35@infradead.org>
From:   SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <1c82a72d-b4f4-68d8-c814-7e44aa3705f1@users.sourceforge.net>
Date:   Wed, 24 May 2017 22:26:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <98579b27-3052-0300-ec67-84f75f761a35@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:Ei3wUrfG2SUbjy3HCTtwp6vq+o4ooxTPaUfJnaxysdz7eX7PrkJ
 yf2YCtoHrXa2Kz1gkgokP6qg520hy4ORWmSc4oGU0bhDMhOP8tCxlYGU6AqyCjpocCcLDgz
 m+Atbscs0kqDj7GpdjUp1XlGMmrR81MAxCQiulypKNwsIln7BT2Ywj0JU3BPUPmaDS8iVXa
 YRM3JmFQgWlWyXs+JJk0A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PlsssINfvC8=:mMcqpSJmiH1KKdFZ1akVLi
 Z7pY/PC/BZbuCe2mTeJs+Jvg3wycljkcz4lwDciQdOawbrsIjBg3NcDOUO2xEQJ4r1QQ5f+7n
 7MYut5P/f8bxK4sii4eSRwKRgcrZYgDRPyGnWGnPVcgQbiTQrM2CaUgM1ShQ43QwXlFg5qo9R
 ivkWfte3hAVSm5TkOagMtaBWvkRMlZA0vUa/2lmsWuzWpTT6w4aLI8sgEikSV4WlArkU5BsrB
 V1CSQjHbTN5sGnxVXV9l5yTN4sJriTzFqEWKvrukZF0vZk8IFA7HhfVC/tiP0YhFSCx9eAKff
 c+Cn4GOqvOCB5+xqD5fp1bCfTEn1u+A/UNkQIvAEIh2WSCaMLOLAkMS16fOJLRKnCjnnDqI6r
 Yv16B1ho75EmARXQc1a/Zthzb0D2IJcJAFqDa9yIMuBmdGI2j7SElGQV2hKkLIogVSiqbtUZV
 ZW+dBUdDOEZ+Oa5raJProIMcioYTBQ4NSamng97s0mSikScfGdiCRlQCdfbsUONg263vgHo8m
 cl4IxfJOcWOpuYPtRS0EIKjjoYVQiidjCqjRlwRjuN9BmpXVifnnt2oZUinyeBVAj2EK0ALaD
 BwA11yr8Ykf85BsZ2BItXkElsqPQm7dU2Vb0IBF8NYaD7cyoOLO405rEJveFYH0qzwy/vPJuJ
 iBS8uGeas7RQovvTsf8CLXxLcf0MtIWquIM7zzPlVjIKXR2HW5B8TIdDk41DXA15FhFKpj60d
 yPjm4rp+x1XCs4GrOhiO38TmgrRNDgEz6kP/PmTUzwHZGDTRg4YhhpeFngkf7XTrnuQd63+UY
 7gl9SAW
Return-Path: <elfring@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57996
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: elfring@users.sourceforge.net
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

> Why just this one error message when there are many in this function?

A bigger software update depends on corresponding change acceptance
and consensus for the evolution of affected error handling, doesn't it?

Regards,
Markus
